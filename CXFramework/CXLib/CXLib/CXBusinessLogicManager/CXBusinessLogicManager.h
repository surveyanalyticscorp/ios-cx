//
//  CXBusinessLogicManager.h
//  CXLib
//
//  Created by Jignesh Raiyani on 4/27/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXBusinessLogicHandler.h"

@interface CXBusinessLogicManager : NSObject

@property (nonatomic,retain) CXBusinessLogicHandler *iBusinessLogicHandle;
+(id)sharedInstance;

#pragma mark - Check previous response for screen
-(BOOL)checkPreviousResponseForScreen:(NSString*)aScreenName;

#pragma mark - get previous response for screen
-(NSMutableDictionary*)getPreviousResponseforKey:(NSString*)aScreenName;

#pragma mark - delete previous response for screen
-(void)deletePreviousResponseforKey:(NSString*)aScreenName;

#pragma mark - add CXresponse to userDefault
-(void)addValueToUserDefault:(NSMutableDictionary*)aValue ForKey:(NSString*)aScreenName;
@end
