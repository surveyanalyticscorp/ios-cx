//
//  CXService.m
//  CXLib
//
//  Created by Jignesh Raiyani on 4/27/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import "CXService.h"
#import "AppConstantCX.h"

@implementation CXService

+(CXService*)service {
    static CXService *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[CXService alloc] init];
    });
    return sharedInstance;
}

-(id)invoke:(CXServiceAsyncInvocation*)invocation withDelegate:(id)delegate {
    [invocation setIURL:kCXServiceUrl];
    [invocation setIDelegate:delegate];
    [invocation invoke];
    return invocation;
}

-(CXTouchPointServiceAsyncInvocation*)touchPointRequestWithTouchPointID:(NSNumber*)aTouchPointID withAPIKey:(NSString*)aAPIKey withDelegate:(id <CXTouchPointServiceDelegate>)aDelegate {
    CXTouchPointServiceAsyncInvocation *invocation = [[CXTouchPointServiceAsyncInvocation alloc] init];
    [invocation setITouchPointID:aTouchPointID];
    [invocation setIUniqueIdentifier:aAPIKey];
    return [self invoke:invocation withDelegate:aDelegate];
}

@end
