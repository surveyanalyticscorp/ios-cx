//
//  CXServiceAsyncInvocation.m
//  CXLib
//
//  Created by Jignesh Raiyani on 4/27/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import "CXServiceAsyncInvocation.h"
#import "NSHTTPURLResponse+StatusCodes.h"
#import "SSKeychain.h"
#import "AppConstantCX.h"

@implementation CXServiceAsyncInvocation
@synthesize iReceivedData;
@synthesize iURL;
@synthesize iUniqueIdentifier;
@synthesize iDelegate;


+(BOOL)isOk:(NSNumber *)statusCode {
    return 200 <= [statusCode intValue] && [statusCode intValue] <= 299;
}

-(id)init {
    self = [super init];
    self.iReceivedData = [[NSMutableData alloc] initWithLength:0];
    return self;
}

-(void)invoke {
}

-(NSString*)udid {
    return [self getUUIDValueFromKeyChain];
}


-(NSString*)getUUIDValueFromKeyChain {
    
    NSString *aUUID = [SSKeychain passwordForService:kDeviceValidationKey account:ApplicationBundleID];
    if ([aUUID length] != 0) {
        return aUUID;
    }else {
        NSString* strUUID = [[self GetUUID] lowercaseString];
        [SSKeychain setPassword:strUUID forService:kDeviceValidationKey account:ApplicationBundleID];
        return strUUID;
    }
}

- (NSString *)GetUUID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

-(NSString*)apikey {
    return [self getApiKey];
}

-(NSString*)getApiKey {
    return self.iUniqueIdentifier;
}

-(void)get:(NSString*)path {
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    NSString* url = [NSMutableString stringWithFormat:@"%@%@", self.iURL,path];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    request.timeoutInterval = 300;
    [self addHeaders:request];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)post:(NSString*)path body:(NSString*)body {
    [self execute:@"POST" path:path body:body];
}

-(void)execute:(NSString*)method path:(NSString*)path body:(NSString*)body {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    NSString* url = [NSMutableString stringWithFormat:@"%@%@", self.iURL,path];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:method];
    request.timeoutInterval = 300;
    if (body) {
        
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        [request setValue:[NSString stringWithFormat:@"%ld", [data length]] forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"text/x-json" forHTTPHeaderField:@"Content-Type"];
    }
        //[self addHeaders:request];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)addHeaders:(NSMutableURLRequest*)request {
        NSString* headerName = @"";
        if (!headerName) {
            headerName = kDefaultClientVersionHeaderName;
        }
        [request setValue:@"" forHTTPHeaderField:headerName];
}

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response {
    [self setIResponse:(NSHTTPURLResponse*)response];

    if (![[self iResponse] isOK]) {
        [self handleHttpError:[[self iResponse] statusCode]];
    }
}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data {
    if ([self.iResponse isOK]) {
        [self.iReceivedData appendData:data];
    }
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}



- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [self handleAuthenticationChallenge:challenge];
    
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [self handleAuthenticationChallenge:challenge];
}

- (void)handleAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge  {
        // Pin the wrong CA certificate => connection should only work if SSL Kill Switch is enabled
    
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        SecTrustRef serverTrust = [[challenge protectionSpace] serverTrust];
        SecTrustResultType trustResult;
        
            // Load the anchor certificate
        NSString *certPath = [[NSBundle mainBundle] pathForResource:@"surveyanalytics" ofType:@"der"];
        
        NSData *anchorCertData = [[NSData alloc] initWithContentsOfFile:certPath];
        if (anchorCertData == nil) {
            NSLog(@"Failed to load the certificates");
            [[challenge sender] cancelAuthenticationChallenge: challenge];
            return;
        }
        
            // Pin the anchor CA and validate the certificate chain
        SecCertificateRef anchorCertificate = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)(anchorCertData));
        NSArray *anchorArray = [NSArray arrayWithObject:(__bridge id)(anchorCertificate)];
        SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)(anchorArray));
        SecTrustEvaluate(serverTrust, &trustResult);
        CFRelease(anchorCertificate);
        
        if (trustResult == kSecTrustResultUnspecified) {
                // Continue connecting
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
                 forAuthenticationChallenge:challenge];
        }
        else {
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
                 forAuthenticationChallenge:challenge];
                // Certificate chain validation failed; cancel the connection
                // [[challenge sender] cancelAuthenticationChallenge: challenge];
        }
    }
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error {
    [self handleHttpError:[[self iResponse] statusCode]];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection {
    BOOL finalize = YES;
    if ([[self iResponse] isOK]) {
        finalize = [self handleHttpOK:self.iReceivedData];
    } else {
        finalize = [self handleHttpError:[[self iResponse] statusCode]];
    }
    if (finalize) {
            //        [self.finalizer finalize:self];
    }
}

-(BOOL)handleHttpError:(NSInteger)code {
        // Override to handle gracefully
    return YES;
}

-(BOOL)handleHttpOK:(NSMutableData*)data {
        // Override to handle gracefully
    return YES;
}

@end
