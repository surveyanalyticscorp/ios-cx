//
//  MobileCX_Library.m
//  MobileCX_Library
//
//  Created by Jignesh Raiyani on 3/30/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import "MobileCX_Library.h"
#import "GlobalDataCX.h"
#import "MobileCXServiceTxManager.h"
#import "GMDCircleLoader.h"
#import "AppConstantCX.h"

@interface MobileCX_Library()<UIAlertViewDelegate,CXServiceDelegate,UIWebViewDelegate>

@property (nonatomic, strong)UIWindow *iBaseWindow;
@property (nonatomic, strong)UIView *iView;
@property (nonatomic, strong)UIWebView *iWebView;
@property (nonatomic, strong)NSString *iResponseURL;
@property (nonatomic, strong)NSString *iPopupMenuTitle;
@property (nonatomic, strong)NSString *iPopupMenuMessage;
@property (nonatomic, strong)NSString *iPopupMenuRightButtonTitle;
@property (nonatomic, strong)NSString *iPopupMenuLeftButtonTitle;
@property (nonatomic, assign)BOOL iPopUpViewFlag;
@property (nonatomic, assign, getter=isPresentViewFlag)BOOL iPresentViewFlag;
@property (nonatomic, strong)NSNumber *iTouchPointName;
@property (nonatomic, strong)NSString *iMobileCXApiKey ,*iCurrentViewName;
@end

@implementation MobileCX_Library

-(instancetype)initwithAPIKey:(NSString*)apiKey withWindow:(UIWindow*)aWindow {
    
    static MobileCX_Library *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [super init];
        [GlobalDataCX checkUUIDValueInKeyChain];
        self.iPopupMenuTitle = @"Feedback";
        self.iPopupMenuMessage = @"Would you like to give us some feedback?";
        self.iPopupMenuRightButtonTitle = @"No";
        self.iPopupMenuLeftButtonTitle = @"Yes";
        self.iPresentViewFlag=TRUE;
        self.iPopUpViewFlag=TRUE;
        self.iMobileCXApiKey =apiKey;
        self.iBaseWindow = aWindow;
        self.iCurrentViewName = @"";
    });
    return sharedManager;
}


-(void)engageTouchPoint:(NSNumber*)aTouchPointID WithViewControllerName:(NSString*)aViewName {
    self.iCurrentViewName = aViewName;
    NSMutableDictionary *responseInfo = [[NSMutableDictionary alloc]init];
    responseInfo = [GlobalDataCX checkValueInUserDefaultforKey:[NSString stringWithFormat:@"%@%@",self.iTouchPointName,self.iCurrentViewName]];
    NSString *surveyURL = [responseInfo valueForKey:ksurveyURL];
    if (surveyURL != nil && surveyURL.length >0) {
        self.iResponseURL = surveyURL;
        [self showMessageInViewControllerWithResponse:responseInfo];
        [GlobalDataCX deleteUserDefaultValueforKey:[NSString stringWithFormat:@"%@%@",self.iTouchPointName,self.iCurrentViewName]];
    }else {
    MobileCXServiceTxManager *aMobileCXServiceTxManager = [[MobileCXServiceTxManager alloc]init];
    self.iTouchPointName = aTouchPointID;
    aMobileCXServiceTxManager.iDelegate = self;
    [aMobileCXServiceTxManager invokeServiceWithTouchPointID:(NSNumber*)aTouchPointID withAPIKey:self.iMobileCXApiKey];
    }
    
}

- (void)stopMobileCXManager {
    NSLog(@"Manager stopped..");
}

-(void)setPopupMenuTitle:(NSString*)aTitle Message:(NSString*)aMessage RightButtonTitle:(NSString*)aRightButtonTitle LeftButtonTitle:(NSString*)aLeftButtonTitle {
    self.iPopupMenuTitle = aTitle;
    self.iPopupMenuMessage = aMessage;
    self.iPopupMenuRightButtonTitle = aRightButtonTitle;
    self.iPopupMenuLeftButtonTitle = aLeftButtonTitle;
}


-(void)showMessageInViewControllerWithResponse:(NSMutableDictionary*)aResponseDict {

    BOOL popUpFlag = [aResponseDict valueForKey:kisDialog];
    
    CGRect rect = [UIApplication sharedApplication].keyWindow.frame;
    rect.origin.x = 0;
    rect.origin.y = 0;
    self.iView = [[UIView alloc]initWithFrame:rect];
    self.iView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    UIView *frontView = [[UIView alloc]init];
    if (popUpFlag) {
        frontView.frame = CGRectMake(30, 70, self.iView.frame.size.width-60, self.iView.frame.size.height-140);
    } else {
        frontView.frame = [UIScreen mainScreen].applicationFrame;
    }
    frontView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *headerImage =[[UIImageView alloc] initWithFrame:CGRectMake(30, 00, frontView.frame.size.width-50,16)];
    headerImage.image=[UIImage imageNamed:@"MobileCX_Resource.bundle/powered-by02x2x.png"];
    headerImage.contentMode = UIViewContentModeScaleAspectFit;
    [frontView addSubview:headerImage];
    
    self.iWebView=[[UIWebView alloc]initWithFrame:CGRectMake(00,16, frontView.frame.size.width, frontView.frame.size.height-16)];
    self.iWebView.delegate=self;
    NSString *url=self.iResponseURL;
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.iWebView setBackgroundColor:[UIColor clearColor]];
    [self.iWebView loadRequest:nsrequest];
    [frontView addSubview:self.iWebView];
    
    [self.iView addSubview:frontView];
    [self.iBaseWindow addSubview:self.iView];
    [self.iBaseWindow bringSubviewToFront:self.iView];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton addTarget:self action:@selector(aDismissWebview:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *closeButtonImage = [UIImage imageNamed:@"MobileCX_Resource.bundle/close-button_2.png"];
    [doneButton setBackgroundImage:closeButtonImage forState:UIControlStateNormal];
    [doneButton setBackgroundColor:[UIColor clearColor]];
    doneButton.layer.cornerRadius = doneButton.bounds.size.width/2;
    if (popUpFlag) {
        doneButton.frame = CGRectMake(self.iView.frame.size.width-80, -10, 30, 30);
    }else {
        doneButton.frame = CGRectMake(0, 0, 0, 0);
        
    }
    [frontView addSubview:doneButton];
    
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
    
        //  [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];
    [GMDCircleLoader hideFromView:self.iWebView animated:YES];
}

-(void)aDismissWebview:(id)sender {
    if (self.iView) {
        [self.iView removeFromSuperview];
    }
}

-(void)currentViewLoaded {
    self.iPresentViewFlag = TRUE;
}

-(void)currentViewUnLoaded {
    self.iPresentViewFlag = FALSE;
}


#pragma mark - CXServiceResponse Delegate
-(void)CXServiceResponseWithURL:(NSMutableDictionary*)aResponseInfo {
    NSString *responseURL = [aResponseInfo valueForKey:ksurveyURL];
    NSLog(@"responseURL %@",[aResponseInfo valueForKey:ksurveyURL]);
    NSLog(@"responsedialog %@",[aResponseInfo valueForKey:kisDialog]);
    if (responseURL != nil && responseURL.length >0 && ![responseURL isEqualToString:@"Empty"]) {
         self.iResponseURL = responseURL;
        NSString *strUserDefaultKey = [NSString stringWithFormat:@"%@%@",self.iTouchPointName,self.iCurrentViewName];
        if (!self.iPresentViewFlag) {
            [GlobalDataCX addValueToUserDefault:aResponseInfo ForKey:strUserDefaultKey];
        }else{
         [self showMessageInViewControllerWithResponse:aResponseInfo];
        }
    }
}

@end