//
//  CXManager.h
//  CXLib
//
//  Created by Jignesh Raiyani on 4/26/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CXManager : NSObject

-(id)initwithAPIKey:(NSString*)apiKey withWindow:(UIWindow*)aWindow;
-(void)engageTouchPoint:(NSNumber*)aTouchPointID WithViewControllerName:(NSString*)aViewName;
-(void)setPopupMenuTitle:(NSString*)aTitle Message:(NSString*)aMessage RightButtonTitle:(NSString*)aTitle LeftButtonTitle:(NSString*)aTitle;
-(void)stopMobileCXManager;
-(void)currentViewStateFlag:(BOOL)aViewState;

@end
