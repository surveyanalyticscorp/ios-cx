//
//  CXBusinessLogicHandler.m
//  CXLib
//
//  Created by Jignesh Raiyani on 4/27/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import "CXBusinessLogicHandler.h"
#import "GlobalDataCX.h"


@implementation CXBusinessLogicHandler

+(id)sharedInstance {
    static CXBusinessLogicHandler *sharedInstance = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[CXBusinessLogicHandler alloc] init];
    });
    return sharedInstance;
}

-(id)initInstances {
    return self;
}

-(BOOL)aCheckPreviousResponseForScreen:(NSString*)aScreenName {
    return [GlobalDataCX checkValueInUserDefaultforKey:aScreenName];
}

#pragma mark - get previous response for screen
-(NSMutableDictionary*)aGetPreviousResponseforKey:(NSString*)aScreenName {
    return [GlobalDataCX getValueFromUserDefaultforKey:aScreenName];
}

#pragma mark - delete previous response for screen
-(void)deletePreviousResponseforKey:(NSString*)aScreenName {
    [GlobalDataCX deleteUserDefaultValueforKey:aScreenName];
}

#pragma mark - add CXresponse to userDefault
-(void)aAddValueToUserDefault:(NSMutableDictionary*)aValue ForKey:(NSString*)aScreenName {
    [GlobalDataCX addValueToUserDefault:aValue ForKey:aScreenName];
}

@end
