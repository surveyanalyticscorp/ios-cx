//
//  MobileCX_Library.h
//  MobileCX_Library
//
//  Created by Jignesh Raiyani on 3/30/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TouchPoint.h"



@interface MobileCX_Library : NSObject

-(instancetype)initwithAPIKey:(NSString*)apiKey withWindow:(UIWindow*)aWindow;
-(void)engageTouchPoint:(NSNumber*)aTouchPointID WithViewControllerName:(NSString*)aViewName;
-(void)engageTouchPointWithParams:(TouchPoint*)touchPoint;
-(void)stopMobileCXManager;
-(void)setPopupMenuTitle:(NSString*)aTitle Message:(NSString*)aMessage RightButtonTitle:(NSString*)aTitle LeftButtonTitle:(NSString*)aTitle;
-(void)currentViewLoaded;
-(void)currentViewUnLoaded;
-(void)showInAppSurvey:(NSString*)surveyUrl withSuperView:(UIView*)appSuperview;
-(TouchPoint*)touchPointBuilder: (NSNumber*)touchPointID;

@end
