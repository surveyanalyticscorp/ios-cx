//
//  CXServiceTXManager.h
//  CXLib
//
//  Created by Jignesh Raiyani on 4/27/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXServiceTXManager : NSObject

+(void)touchPointServiceInvocation:(id)aDelegate withTouchPointID:(NSNumber*)aTouchPointID withAPIKey:(NSString*)aAPIKey;

@end
