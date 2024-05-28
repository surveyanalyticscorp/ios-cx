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

-(instancetype) initWithTouchPointID: (NSNumber*) touchPointID {
    self = [super init];
    if (self) {
        self.email = @"";
        self.firstName = @"";
        self.lastName = @"";
        self.mobile = @"";
        self.segmentCode = @"";
        self.iTouchPointID = touchPointID;
    }
    return self;
}

@end
