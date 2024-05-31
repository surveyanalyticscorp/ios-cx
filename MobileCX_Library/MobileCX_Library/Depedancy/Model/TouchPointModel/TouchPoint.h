//
//  TouchPointID.h
//  MobileCX_Library
//
//  Created by Jignesh Raiyani on 4/18/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import <Foundation/Foundation.h>

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
-(instancetype) initWithTouchPointID: (NSNumber*)touchPointID;
@end
