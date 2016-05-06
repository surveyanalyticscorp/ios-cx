//
//  GlobalData.h
//  MobileCX_Library
//
//  Created by Jignesh Raiyani on 3/30/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalDataCX : NSObject

+(void)writeValueToKeyChain;
+(NSString*)getUUIDValueFromKeyChain;
+(void)addValueToUserDefault:(NSMutableDictionary*)aValue ForKey:(NSString*)aTouchPointIDKey;
+(void)deleteUserDefaultValueforKey:(NSString*)aTouchPointIDKey;
+(NSMutableDictionary*)getValueFromUserDefaultforKey:(NSString*)aTouchPointIDKey;
+(BOOL)checkValueInUserDefaultforKey:(NSString*)aTouchPointIDKey;
+(NSString *)getPlistPath:(NSString*)plistName;
+(void)writeTOPlistFromDictionary:(NSMutableDictionary*)aCXResponseDict;
+(NSMutableDictionary*)getDictFromPList;

@end
