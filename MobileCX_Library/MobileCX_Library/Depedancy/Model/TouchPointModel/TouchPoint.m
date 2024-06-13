//
//  TouchPointID.m
//  MobileCX_Library
//
//  Created by Jignesh Raiyani on 4/18/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import "TouchPoint.h"

@implementation TouchPoint

@synthesize email;
@synthesize firstName;
@synthesize lastName;
@synthesize mobile;
@synthesize segmentCode;
@synthesize iTouchPointID;
@synthesize isShowInDialog;
@synthesize customVariable1;
@synthesize customVariable2;
@synthesize customVariable3;

-(instancetype) initWithTouchPointID: (NSNumber*) touchPointID {
    self = [super init];
    if (self) {
        self.email = @"";
        self.firstName = @"";
        self.lastName = @"";
        self.mobile = @"";
        self.segmentCode = @"";
        self.isShowInDialog = @0; //boolean false value
        self.iTouchPointID = touchPointID;
        self.customVariable1 = @"";
        self.customVariable2 = @"";
        self.customVariable3 = @"";
    }
    return self;
}

@end
