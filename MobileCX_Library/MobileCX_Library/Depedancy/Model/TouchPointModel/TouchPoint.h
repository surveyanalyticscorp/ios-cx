//
//  TouchPointID.h
//  MobileCX_Library
//
//  Created by Jignesh Raiyani on 4/18/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DataCenter) {
    DATA_CENTER_US,
    DATA_CENTER_AE,
    DATA_CENTER_CA,
    DATA_CENTER_AU,
    DATA_CENTER_EU,
    DATA_CENTER_SG,
    DATA_CENTER_SA,
    DATA_CENTER_KSA,
};

@interface TouchPoint : NSObject

@property(nonatomic,strong)NSNumber *iTouchPointID;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *firstName;
@property(nonatomic,strong)NSString *lastName;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *segmentCode;
@property(nonatomic, strong)NSNumber *isShowInDialog;
@property(nonatomic, strong)NSString *customVariable1;
@property(nonatomic, strong)NSString *customVariable2;
@property(nonatomic, strong)NSString *customVariable3;
@property(nonatomic, assign)DataCenter dataCenter;
-(instancetype) initWithTouchPointID: (NSNumber*)touchPointID;
@end
