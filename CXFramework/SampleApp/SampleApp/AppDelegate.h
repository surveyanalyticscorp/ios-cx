//
//  AppDelegate.h
//  SampleApp
//
//  Created by Jignesh Raiyani on 4/27/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CXLib/CXManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CXManager *iCXManager;
+(AppDelegate *)sharedAppDelegate;

@end

