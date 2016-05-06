//
//  CXBusinessLogicManager.m
//  CXLib
//
//  Created by Jignesh Raiyani on 4/27/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import "CXBusinessLogicManager.h"

@implementation CXBusinessLogicManager

+(id)sharedInstance {
    static CXBusinessLogicManager *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[CXBusinessLogicManager alloc] initManagers];
    });
    
    return sharedInstance;
}

-(id)initManagers {
    self.iBusinessLogicHandle = [CXBusinessLogicHandler sharedInstance];
    return self;
}

#pragma mark - Check previous response for screen
-(BOOL)checkPreviousResponseForScreen:(NSString*)aScreenName {
    return [self.iBusinessLogicHandle aCheckPreviousResponseForScreen:aScreenName];
}

#pragma mark - get previous response for screen
-(NSMutableDictionary*)getPreviousResponseforKey:(NSString*)aScreenName {
    return [self.iBusinessLogicHandle aGetPreviousResponseforKey:aScreenName];
}

#pragma mark - delete previous response for screen
-(void)deletePreviousResponseforKey:(NSString*)aScreenName {
    [self.iBusinessLogicHandle aDeletePreviousResponseforKey:aScreenName];
}

#pragma mark - add CXresponse to userDefault
-(void)addValueToUserDefault:(NSMutableDictionary*)aValue ForKey:(NSString*)aScreenName {
    [self.iBusinessLogicHandle aAddValueToUserDefault:aValue ForKey:aScreenName];
}


@end
