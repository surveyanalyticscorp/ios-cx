//
//  CXService.h
//  CXLib
//
//  Created by Jignesh Raiyani on 4/27/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXTouchPointServiceAsyncInvocation.h"

@interface CXService : NSObject

+(CXService*)service;

-(CXTouchPointServiceAsyncInvocation*)touchPointRequestWithTouchPointID:(NSNumber*)aTouchPointID withAPIKey:(NSString*)aAPIKey withDelegate:(id <CXTouchPointServiceDelegate>)aDelegate;
@end
