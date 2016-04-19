//
//  MobileCXLaunchView.m
//  MobileCX_Library
//
//  Created by Jignesh Raiyani on 4/18/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import "MobileCXLaunchView.h"
#import "GMDCircleLoader.h"

@implementation MobileCXLaunchView
@synthesize iDelegate;
@synthesize iWebView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(UIView*)mobileCXLaunchViewWithURL:(NSString*)aURLValue {
    
    CGRect rect = [UIApplication sharedApplication].keyWindow.frame;
    rect.origin.x = 0;
    rect.origin.y = 0;
    UIView * launchView = [[UIView alloc]initWithFrame:rect];
    launchView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    UIView *frontView = [[UIView alloc]init];
        //  if (self.iPopUpViewFlag) {
        frontView.frame = CGRectMake(30, 70, launchView.frame.size.width-60, launchView.frame.size.height-140);
//    } else {
//        frontView.frame = [UIScreen mainScreen].applicationFrame;
//    }
    frontView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *headerImage =[[UIImageView alloc] initWithFrame:CGRectMake(30, 00, frontView.frame.size.width-50,16)];
    headerImage.image=[UIImage imageNamed:@"MobileCX_Resource.bundle/powered-by02x2x.png"];
    headerImage.contentMode = UIViewContentModeScaleAspectFit;
    [frontView addSubview:headerImage];
    
    self.iWebView=[[UIWebView alloc]initWithFrame:CGRectMake(00,16, frontView.frame.size.width, frontView.frame.size.height-30)];
    self.iWebView.delegate=self;
    NSString *url=aURLValue;
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.iWebView loadRequest:nsrequest];
    [frontView addSubview:self.iWebView];
    
    [launchView addSubview:frontView];
//    [self.iBaseWindow addSubview:self.iView];
//    [self.iBaseWindow bringSubviewToFront:self.iView];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton addTarget:self action:@selector(aDismissWebview:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *closeButtonImage = [UIImage imageNamed:@"MobileCX_Resource.bundle/close-button_2.png"];
    [doneButton setBackgroundImage:closeButtonImage forState:UIControlStateNormal];
    [doneButton setBackgroundColor:[UIColor clearColor]];
    doneButton.layer.cornerRadius = doneButton.bounds.size.width/2;
        //    if (self.iPopUpViewFlag) {
        doneButton.frame = CGRectMake(launchView.frame.size.width-80, -10, 30, 30);
//    }else {
//        doneButton.frame = CGRectMake(0, 0, 30, 30);
//        
//    }
    [frontView addSubview:doneButton];
    
    return launchView;
}

-(void)aDismissWebview:(id)sender {
//    if (self.iView) {
//        [self.iView removeFromSuperview];
//    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)requestURL navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [requestURL URL];
    NSLog(@"##### url = %@",[url absoluteString]);
    NSRange range = [[url absoluteString] rangeOfString:@"#autoClose"];
    if (range.location != NSNotFound){
        [self performSelector:@selector(aDismissWebview:) withObject:self afterDelay:4.0];
    }
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    [GMDCircleLoader setOnView:self.iWebView withTitle:@"Loading..." animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Failed to load with error :%@",[error debugDescription]);
    [GMDCircleLoader hideFromView:self.iWebView animated:YES];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];
    [GMDCircleLoader hideFromView:self.iWebView animated:YES];
}
@end
