//
//  CXTouchPointServiceAsyncInvocation.h
//  CXLib
//
//  Created by Jignesh Raiyani on 4/27/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import "CXServiceAsyncInvocation.h"
@class CXTouchPointServiceAsyncInvocation;

@protocol CXTouchPointServiceDelegate
-(void)touchPointRequestDidFinish:(CXTouchPointServiceAsyncInvocation*)invocation withError:(NSError*)error;

@end

@interface CXTouchPointServiceAsyncInvocation : CXServiceAsyncInvocation


@property (nonatomic,strong) NSNumber *iTouchPointID;

@end
