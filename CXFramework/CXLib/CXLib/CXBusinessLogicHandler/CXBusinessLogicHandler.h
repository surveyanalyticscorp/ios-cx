//
//  CXBusinessLogicHandler.h
//  CXLib
//
//  Created by Jignesh Raiyani on 4/27/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXBusinessLogicHandler : NSObject

+(id)sharedInstance;

#pragma mark - Check previous response for screen
-(BOOL)aCheckPreviousResponseForScreen:(NSString*)aScreenName;

#pragma mark - get previous response for screen
-(NSMutableDictionary*)aGetPreviousResponseforKey:(NSString*)aScreenName;

#pragma mark - delete previous response for screen
-(void)aDeletePreviousResponseforKey:(NSString*)aScreenName;

#pragma mark - add CXresponse to userDefault
-(void)aAddValueToUserDefault:(NSMutableDictionary*)aValue ForKey:(NSString*)aScreenName;

@end
