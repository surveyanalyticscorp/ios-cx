//
//  GlobalData.m
//  MobileCX_Library
//
//  Created by Jignesh Raiyani on 3/30/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import "GlobalDataCX.h"
#import "SSKeychain.h"
#import "AppConstantCX.h"


@implementation GlobalDataCX


#pragma mark

+(NSString*)getUUIDValueFromKeyChain {
    
    NSString *aUUID = [SSKeychain passwordForService:kDeviceValidationKey account:ApplicationBundleID];
    if ([aUUID length] != 0) {
        return aUUID;
    }else {
        NSString* strUUID = [[self GetUUID] lowercaseString];
        [SSKeychain setPassword:strUUID forService:kDeviceValidationKey account:ApplicationBundleID];
        return strUUID;
    }
}

+(NSString *)GetUUID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

+(void)addValueToUserDefault:(id)aValue ForKey:(NSMutableDictionary*)aTouchPointIDKey {
    [[NSUserDefaults standardUserDefaults] setObject:aValue forKey:[NSString stringWithFormat:@"%@",aTouchPointIDKey]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)deleteUserDefaultValueforKey:(NSString*)aTouchPointIDKey {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@",aTouchPointIDKey]];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

+(NSMutableDictionary*)getValueFromUserDefaultforKey:(NSString*)aTouchPointIDKey {
    NSMutableDictionary *defaultValue = [[NSMutableDictionary alloc]init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@",aTouchPointIDKey]]) {
        defaultValue = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@",aTouchPointIDKey]];
    }
    return defaultValue;
}

+(BOOL)checkValueInUserDefaultforKey:(NSString*)aTouchPointIDKey {
    BOOL defaultValue = FALSE;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@",aTouchPointIDKey]]) {
        defaultValue = TRUE;
    }
    return defaultValue;
}

+(NSString *)getPlistPath:(NSString*)plistName{
        // create full DB path
    NSBundle *staticLibBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"CXResource" ofType:@"bundle"]];
    NSString *filePath   = [staticLibBundle pathForResource:@"CXServiceResponse" ofType:@"plist"];
        // NSLog(@"plist path %@",filePath);
    return filePath;
}

+(void)writeTOPlistFromDictionary:(NSMutableDictionary*)aCXResponseDict
{
    @try{
        if (![aCXResponseDict writeToFile:[GlobalDataCX getPlistPath:kCXServiceResponsePlistName] atomically:YES])
            NSLog(@"response not saved!");
    }@catch(NSException *e){
            NSLog(@"Exception -:writePlistFromDictionary :%@", [e reason]);
    }
}

+(NSMutableDictionary*)getDictFromPList {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:[self getPlistPath:kCXServiceResponsePlistName]];
    return dict;
}

@end
