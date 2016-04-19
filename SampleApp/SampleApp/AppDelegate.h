//
//  AppDelegate.h
//  SampleApp
//
//  Created by Jignesh Raiyani on 4/18/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobileCX_Library/MobileCX_Library.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MobileCX_Library *iMobileCX_Library;
+(AppDelegate *)sharedAppDelegate;

@end

