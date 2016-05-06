//
//  CXServiceAsyncInvocation.h
//  CXLib
//
//  Created by Jignesh Raiyani on 4/27/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXServiceAsyncInvocation : NSObject

@property (nonatomic, strong) NSMutableData *iReceivedData;
@property (nonatomic, strong) NSHTTPURLResponse *iResponse;
@property (nonatomic, strong) NSString *iURL;
@property (nonatomic,strong) NSString *iUniqueIdentifier;
@property (nonatomic, weak) id iDelegate;


-(void)post:(NSString*)path body:(NSString*)body;
-(void)get:(NSString*)path;
-(NSString*)udid;
-(NSString*)apikey;
-(void)invoke;

@end
