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


@implementation GlobalDataCX


#pragma mark

+(void)writeValueToKeyChain
{
    NSString* aUUID = [[NSUUID UUID] UUIDString];
    KeychainItemWrapper *keychain = nil;
    keychain = [[KeychainItemWrapper alloc] initWithIdentifier:kKeyChainWrapperBundleId accessGroup:nil];
    [keychain setObject:aUUID forKey:(__bridge id)kSecValueData];
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
