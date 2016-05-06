//
//  CXServiceTXManager.m
//  CXLib
//
//  Created by Jignesh Raiyani on 4/27/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import "CXServiceTXManager.h"
#import "CXService.h"

@implementation CXServiceTXManager

+(void)touchPointServiceInvocation:(id)aDelegate withTouchPointID:(NSNumber*)aTouchPointID withAPIKey:(NSString*)aAPIKey{
    CXTouchPointServiceAsyncInvocation* invocation = nil;
    CXService *service = [CXService service];
    invocation = [service touchPointRequestWithTouchPointID:aTouchPointID withAPIKey:aAPIKey withDelegate:aDelegate];
}

@end
