//
//  ViewController.m
//  SampleApp
//
//  Created by Jignesh Raiyani on 4/18/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TouchPoint *touchPoint = [[TouchPoint alloc] initWithTouchPointID:@(11543908)];
    
    //Here user can set available params like email, firstName, lastName, mobile and segmentCode.
    //If nothing is set all of these params are set to "" i.e. empty string as default values.
//    touchPoint.email = @"prasad.bhide@quetionpro.com";
    touchPoint.firstName = @"Prasad";
    touchPoint.lastName = @"Bhide";
    touchPoint.customVariable1 = @"Pune";
    touchPoint.customVariable2 = @"India";
    touchPoint.customVariable3 = @"Wakad";

    [[AppDelegate sharedAppDelegate].iMobileCX_Library engageTouchPointWithParams: touchPoint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
