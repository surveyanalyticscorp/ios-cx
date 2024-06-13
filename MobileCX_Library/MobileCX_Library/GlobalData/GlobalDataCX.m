//
//  GlobalData.m
//  MobileCX_Library
//
//  Created by Jignesh Raiyani on 3/30/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import "GlobalDataCX.h"
#import "KeychainItemWrapper.h"
#import "AppConstantCX.h"
#import "TouchPoint.h"


@implementation GlobalDataCX


#pragma mark

+(void)writeValueToKeyChain
{
    NSString* aUUID = [[NSUUID UUID] UUIDString];
    KeychainItemWrapper *keychain = nil;
    keychain = [[KeychainItemWrapper alloc] initWithIdentifier:kKeyChainWrapperBundleId accessGroup:nil];
    [keychain setObject:aUUID forKey:(__bridge id)kSecValueData];
}

+(NSString*) getDataCenterString: (DataCenter) dataCenter {
    if (dataCenter == DATA_CENTER_US) {
        return @"US";
    }
        
    if (dataCenter == DATA_CENTER_AE) {
        return @"AE";
    }
        
    if (dataCenter == DATA_CENTER_CA) {
        return @"CA";
    }
        
    if (dataCenter == DATA_CENTER_AU) {
        return @"AU";
    }
    
    if (dataCenter == DATA_CENTER_EU) {
        return @"EU";
    }
    
    if (dataCenter == DATA_CENTER_SG) {
        return @"SG";
    }
        
    if (dataCenter == DATA_CENTER_SA) {
        return @"SA";
    }
    
    if (dataCenter == DATA_CENTER_KSA) {
        return @"KSA";
    }
    return @"US";
}

+(NSString*) getBaseUrl:(NSString*) dataCenter {
    if ([dataCenter isEqualToString :@"US"]) {
        return @"https://api.questionpro.com";
    } else if ([dataCenter isEqualToString :@"AE"]){
        return @"https://api.questionpro.ae";
    } else if ([dataCenter isEqualToString :@"AU"]){
        return @"https://api.questionpro.au";
    } else if ([dataCenter isEqualToString :@"EU"]){
        return @"https://api.questionpro.eu";
    } else if ([dataCenter isEqualToString :@"CA"]){
        return @"https://api.questionpro.ca";
    }else if ([dataCenter isEqualToString :@"SG"]){
        return @"https://api.questionpro.sg";
    } else if ([dataCenter isEqualToString :@"SA"]){
        return @"https://api.surveyanalytics.com";
    } else if ([dataCenter isEqualToString :@"KSA"]){
        return @"https://api.questionprosa.com";
    }
       
    return @"https://api.questionpro.com";
}

+(NSString*)getUUIDValueFromKeyChain {
    KeychainItemWrapper *keychain = nil;
    keychain = [[KeychainItemWrapper alloc] initWithIdentifier:kKeyChainWrapperBundleId accessGroup:nil];
    NSString *strudid = (NSString*)[keychain objectForKey:(__bridge id)(kSecValueData)];
        // strudid = [strudid stringByReplacingOccurrencesOfString:@"<" withString:@""];
        // strudid = [strudid stringByReplacingOccurrencesOfString:@">" withString:@""];
    return [NSString stringWithFormat:@"%@",strudid];
}

+(BOOL)checkUUIDValueInKeyChain {
    
    KeychainItemWrapper *keychain = nil;
    keychain = [[KeychainItemWrapper alloc] initWithIdentifier:kKeyChainWrapperBundleId accessGroup:nil];
    NSString *strudid = [keychain objectForKey:(__bridge id)(kSecValueData)];
    
    if ([strudid length] != 0) {
        return TRUE;
    }else {
        [GlobalDataCX writeValueToKeyChain];
        return FALSE;
    }
}

+(void)addValueToUserDefault:(id)aValue ForKey:(NSMutableDictionary*)aTouchPointIDKey {
    [[NSUserDefaults standardUserDefaults] setObject:aValue forKey:[NSString stringWithFormat:@"%@",aTouchPointIDKey]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void) addToUserDefault:(NSNumber *)value ForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:[NSString stringWithFormat:@"%@",key]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSNumber*) getValueFromUserDefault:(NSString *)key {
    NSNumber *defaultValue = [[NSNumber alloc]init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@",key]]) {
        defaultValue = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@",key]];
    }
    return defaultValue;
}

+(void)deleteUserDefaultValueforKey:(NSString*)aTouchPointIDKey {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@",aTouchPointIDKey]];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

+(NSMutableDictionary*)checkValueInUserDefaultforKey:(NSString*)aTouchPointIDKey {
    NSMutableDictionary *defaultValue = [[NSMutableDictionary alloc]init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@",aTouchPointIDKey]]) {
        defaultValue = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@",aTouchPointIDKey]];
    }
    return defaultValue;
}

@end
