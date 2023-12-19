//
//  ServiceTxManager.m
//  SurveyPocket
//
//  Created by Shreyas G on 03/08/15.
//  Copyright (c) 2015 SurveyAnalytics. All rights reserved.
//

#import "MobileCXServiceTxManager.h"
#import "GlobalDataCX.h"
#import "TouchPoint.h"

#define kMobileCXServiceUrl    @"https://api.questionpro.com/a/api"
#define kSAOfflineServiceKey @"87f682bb-bab3-4099-b7e9-da8779bba6b0"


@implementation MobileCXServiceTxManager
@synthesize response = _response;
@synthesize receivedData = _receivedData;

-(id)init {
    self = [super init];
    _receivedData = [[NSMutableData alloc] initWithLength:0];
    return self;
}



-(void)invokeServiceWithTouchPointID:(TouchPoint*) touchPoint withAPIKey:(NSString*)apikey
{
    NSString* path = nil;
    path = [NSString stringWithFormat:@"/questionpro.cx.getSurveyURL?apiKey=%@",apikey];
    
    NSString* body = nil;
    body = [self createCXRequestWithTouchPointID:touchPoint];
    
    [self execute:@"POST" path:path body:body];
}

-(NSString*)createCXRequestWithTouchPointID:(TouchPoint*) touchPoint {
    NSString* cxRequestString = nil;
    
    NSMutableDictionary *cxRequestDict = [[NSMutableDictionary alloc] init];
    [cxRequestDict setObject:touchPoint.iTouchPointID forKey:@"surveyID"];
    [cxRequestDict setObject:touchPoint.email forKey:@"email"];
    [cxRequestDict setObject:touchPoint.firstName forKey:@"firstName"];
    [cxRequestDict setObject:touchPoint.lastName forKey:@"lastName"];
    [cxRequestDict setObject:touchPoint.mobile forKey:@"mobile"];
    [cxRequestDict setObject:touchPoint.segmentCode forKey:@"S1"];
    NSError *error = nil;
    NSData *uploadData;
        // Dictionary convertable to JSON ?
    if ([NSJSONSerialization isValidJSONObject:cxRequestDict] )
        {
            // Serialize the dictionary
        uploadData = [NSJSONSerialization dataWithJSONObject:cxRequestDict options:NSJSONWritingPrettyPrinted error:&error];
        
            // If no errors, let's view the JSON
        if (uploadData != nil && error == nil)
            {
            cxRequestString = [[NSString alloc] initWithData:uploadData encoding:NSUTF8StringEncoding];
                //NSLog(@"JSON: %@", uploadString);
            }
        }
     return cxRequestString;
}

-(void)execute:(NSString*)method path:(NSString*)path body:(NSString*)body {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    NSString* url = [NSMutableString stringWithFormat:@"%@%@", kMobileCXServiceUrl,path];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:method];
    request.timeoutInterval = 300;
    if (body) {
        
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        [request setValue:[NSString stringWithFormat:@"%ld", [data length]] forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"text/x-json" forHTTPHeaderField:@"Content-Type"];
    }
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)get:(NSString*)path {
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    NSString* url = [NSMutableString stringWithFormat:@"%@%@", kMobileCXServiceUrl,path];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    request.timeoutInterval = 300;
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response {
    [self setResponse:(NSHTTPURLResponse*)response];
    if (response) {
        NSDictionary* headers = [_response allHeaderFields];
        for (NSString* key in headers) {
            NSLog(@"%s HEADER[%@]=>%@",__FUNCTION__,key,[headers objectForKey:key]);
        }
    }
}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data {
        [_receivedData appendData:data];
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
        /*NSString *certPath = [[NSBundle mainBundle] pathForResource:@"surveyanalytics" ofType:@"cer"];
        
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
        }*/
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
             forAuthenticationChallenge:challenge];
    }
}


-(BOOL)handleHttpError:(NSInteger)code {
        // Override to handle gracefully
    return YES;
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error {
    [self handleHttpError:[[self response] statusCode]];
        //	[self.finalizer finalize:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection {
        // Delay execution of my block for 10 seconds.
        //  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self handleHttpOK:self.receivedData];
        //  });
        //  [self handleHttpOK:self.receivedData];
}

-(BOOL)handleHttpOK:(NSMutableData*)data
{
    
        //    NSString* json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *jsonData = nil;
    NSError *error;
    if ([NSJSONSerialization JSONObjectWithData:data
                                        options:kNilOptions
                                          error:&error] != nil)
        {
        jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if([NSJSONSerialization isValidJSONObject:jsonData]){
            NSLog(@"data is JSON");
            if ([jsonData objectForKey:@"status"]) {
                NSDictionary* statusd = [jsonData objectForKey:@"status"];
                NSNumber* statusId = [statusd objectForKey:@"id"];
                if ([statusId intValue] == 200) {
                    [self processJson:jsonData];
                }
                else
                    {
                    NSString * errorMessage = nil;
                    if ([statusId intValue] == 500 ) {
                        errorMessage = @"invalid request";
                    }
                    else if ([statusId intValue] == 0)
                        {
                        errorMessage = @"No Internet Connection Detected.";
                        }
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"SurveyPocketApp" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        // [alertView show];
                    }
            }
        }
        else{
            NSLog(@"data is not JSON");
        }
        }
    else
        {
            // Handle error
        NSLog(@"Invalid Data");
        }
    return NO;
}

-(void)processJson:(NSMutableDictionary*)json{
     NSMutableDictionary* jsonDict = [json valueForKey:@"response"];
    NSString *surveyURL = [jsonDict valueForKey:@"SurveyURL"];
    if([self.iDelegate respondsToSelector:@selector(CXServiceResponseWithURL:)]) {
            [self.iDelegate CXServiceResponseWithURL:jsonDict];
    }
}
@end
