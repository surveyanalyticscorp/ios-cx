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
//    [[AppDelegate sharedAppDelegate].iMobileCX_Library engageTouchPoint:@(7519310) WithViewControllerName:@"DemoLaunchView"];
    [[AppDelegate sharedAppDelegate].iMobileCX_Library showInAppSurvey:@"https://testwww.questionpro.com/t/mthZth" withSuperView: self.view];
//    self.view.hidden = TRUE;
    //6802488
    //Intercept survey touchpointid: 7657541
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
