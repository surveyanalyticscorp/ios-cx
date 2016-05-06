//
//  MobileCXLaunchView.h
//  MobileCX_Library
//
//  Created by Jignesh Raiyani on 4/18/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MobileCXLaunchViewDelegate
- (void)closeButtonAction;
@end

@interface MobileCXLaunchView : UIView <UIWebViewDelegate>

@property (assign) id <MobileCXLaunchViewDelegate> iDelegate;
@property (nonatomic, strong)UIWebView *iWebView;

-(UIView*)mobileCXLaunchViewWithURL:(NSString*)aURLValue;
@end
