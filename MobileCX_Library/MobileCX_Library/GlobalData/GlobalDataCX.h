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
+(BOOL)checkUUIDValueInKeyChain;
+(void)addValueToUserDefault:(NSMutableDictionary*)aValue ForKey:(NSString*)aTouchPointIDKey;
+(void)addToUserDefault: (NSNumber*)value ForKey: (NSString*)key;
+(NSNumber*) getValueFromUserDefault: (NSString*) key;
+(void)deleteUserDefaultValueforKey:(NSString*)aTouchPointIDKey;
+(NSMutableDictionary*)checkValueInUserDefaultforKey:(NSString*)aTouchPointIDKey;


@end
