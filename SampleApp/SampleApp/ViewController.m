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
    [[AppDelegate sharedAppDelegate].iMobileCX_Library engageTouchPoint:@(118) WithViewControllerName:@"DemoLaunchView"];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
