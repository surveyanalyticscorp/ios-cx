//
//  ServiceTxManager.h
//  SurveyPocket
//
//  Created by Shreyas G on 03/08/15.
//  Copyright (c) 2015 SurveyAnalytics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol CXServiceDelegate <NSObject>

@optional
-(void)CXServiceResponseWithURL:(NSMutableDictionary*)ResponseURL;

@end

@interface MobileCXServiceTxManager : NSObject
{
    NSMutableData* _receivedData;
    NSHTTPURLResponse* _response;


}

@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSHTTPURLResponse* response;
@property (weak , nonatomic) id <CXServiceDelegate> iDelegate;
-(void)invokeServiceWithTouchPointID:(NSNumber*)aTouchPointID withAPIKey:(NSString*)apikey;

@end
