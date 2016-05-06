//
//  CXTouchPointServiceAsyncInvocation.m
//  CXLib
//
//  Created by Jignesh Raiyani on 4/27/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import "CXTouchPointServiceAsyncInvocation.h"
#import "GlobalDataCX.h"
#import "AppConstantCX.h"

@implementation CXTouchPointServiceAsyncInvocation
@synthesize iTouchPointID;

-(void)invoke {
    NSString* path = nil;
    path = [NSString stringWithFormat:@"/questionpro.cx.mobileTouchpoint?apiKey=%@",[self apikey]];
    NSLog(@"%@",path);
    NSString* body = nil;
    body = [self createCXRequestWithTouchPointID];
    
    [self post:path body:body];
}

-(NSString*)createCXRequestWithTouchPointID {
    NSString* cxRequestString = nil;
    NSMutableDictionary *cxRequestDict = [[NSMutableDictionary alloc] init];
    [cxRequestDict setObject:[self udid] forKey:@"udid"];
    [cxRequestDict setObject:self.iTouchPointID forKey:@"touchPointID"];
    NSError *error = nil;
    NSData *uploadData;
    
        // Dictionary convertable to JSON ?
    if ([NSJSONSerialization isValidJSONObject:cxRequestDict]) {
            // Serialize the dictionary
        uploadData = [NSJSONSerialization dataWithJSONObject:cxRequestDict options:NSJSONWritingPrettyPrinted error:&error];
            // If no errors, let's view the JSON
        if (uploadData != nil && error == nil) {
            cxRequestString = [[NSString alloc] initWithData:uploadData encoding:NSUTF8StringEncoding];
            }
    }
    return cxRequestString;
}

-(BOOL)handleHttpError:(NSInteger)code {
    return YES;
}

-(BOOL)handleHttpOK:(NSMutableData*)data {
    
    NSString* json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *jsonData = nil;
    NSError *error;
    if ([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] != nil) {
        jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if([NSJSONSerialization isValidJSONObject:jsonData]){
            NSLog(@"data is JSON");
            if ([jsonData objectForKey:@"status"]) {
                NSDictionary* statusd = [jsonData objectForKey:@"status"];
                NSNumber* statusId = [statusd objectForKey:@"id"];
                if ([statusId intValue] == 200) {
                    [self processJson:jsonData];
                    [self.iDelegate touchPointRequestDidFinish:self withError:nil];
                }else {
                    NSString * errorMessage = @"";
                         [self.iDelegate touchPointRequestDidFinish:self withError:[NSError errorWithDomain:@"Error" code:[statusId intValue] userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:@"message"]]];
                    }
            }
        }
        else{
            NSLog(@"data is not JSON");
        }
        } else {
            // Handle error
        NSLog(@"Invalid Data");
        }
    return NO;
}

-(void)processJson:(NSDictionary*)json
{
    NSMutableDictionary* jsonDict = [json valueForKey:@"response"];
    NSLog(@"cxresponse %@",[json valueForKey:@"response"]);
    if (jsonDict) {
        NSMutableDictionary *cxResponseDict = [[NSMutableDictionary alloc]init];
        if ([jsonDict valueForKey:ksurveyURL])
            [cxResponseDict setObject:[jsonDict valueForKey:ksurveyURL] forKey:ksurveyURL];
        else
            [cxResponseDict setObject:@"" forKey:ksurveyURL];
        
        if ([jsonDict valueForKey:kisDialog])
            [cxResponseDict setObject:[jsonDict valueForKey:kisDialog] forKey:kisDialog];
        else
            [cxResponseDict setObject:@(0) forKey:kisDialog];
            
        [GlobalDataCX writeTOPlistFromDictionary:cxResponseDict];
    }
        
}

@end
