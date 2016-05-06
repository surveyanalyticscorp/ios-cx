//
//  CXManager.m
//  CXLib
//
//  Created by Jignesh Raiyani on 4/26/16.
//  Copyright © 2016 QuestionPro. All rights reserved.
//

#import "CXManager.h"
#import "GlobalDataCX.h"
#import "CXServiceTXManager.h"
#import "CXBusinessLogicManager.h"
#import "GMDCircleLoader.h"
#import "AppConstantCX.h"
#import "CXTouchPointServiceAsyncInvocation.h"

@interface CXManager()<UIAlertViewDelegate,UIWebViewDelegate>

@property (nonatomic, strong)UIWindow *iBaseWindow;
@property (nonatomic, strong)UIView *iView;
@property (nonatomic, strong)UIWebView *iWebView;
@property (nonatomic, strong)NSString *iResponseURL;
@property (nonatomic, strong)NSString *iPopupMenuTitle;
@property (nonatomic, strong)NSString *iPopupMenuMessage;
@property (nonatomic, strong)NSString *iPopupMenuRightButtonTitle;
@property (nonatomic, strong)NSString *iPopupMenuLeftButtonTitle;
@property (nonatomic, assign)BOOL iPopUpViewFlag;
@property (nonatomic, assign)BOOL iPresentViewFlag;
@property (nonatomic, strong)NSNumber *iTouchPointName;
@property (nonatomic, strong)NSString *iCXApiKey, *iCurrentScreenName;
@property (nonatomic, strong)CXBusinessLogicManager *iBusinessLogicManager;
@end

@implementation CXManager

-(instancetype)initwithAPIKey:(NSString*)apiKey withWindow:(UIWindow*)aWindow {
    
    static CXManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [super init];
        self.iPopupMenuTitle = @"Feedback";
        self.iPopupMenuMessage = @"Would you like to give us some feedback?";
        self.iPopupMenuRightButtonTitle = @"No";
        self.iPopupMenuLeftButtonTitle = @"Yes";
        self.iPresentViewFlag=TRUE;
        self.iPopUpViewFlag=TRUE;
        self.iCXApiKey =apiKey;
        self.iBaseWindow = aWindow;
        self.iCurrentScreenName = @"";
        self.iBusinessLogicManager = [CXBusinessLogicManager sharedInstance];
    });
    return sharedManager;
}

//+(id)initwithAPIKey:(NSString*)apiKey withWindow:(UIWindow*)aWindow {
//    static CXManager *sharedManager = nil;
//    static dispatch_once_t pred;
//    dispatch_once(&pred, ^{
//        sharedManager = [[CXManager alloc] initManagerwithAPIKey:apiKey withWindow:aWindow];
//    });
//    return sharedManager;
//}
//
//-(id)initManagerwithAPIKey:(NSString*)apiKey withWindow:(UIWindow*)aWindow {
//    self.iBusinessLogicManager = [CXBusinessLogicManager sharedInstance];
//    self.iPopupMenuTitle = @"Feedback";
//    self.iPopupMenuMessage = @"Would you like to give us some feedback?";
//    self.iPopupMenuRightButtonTitle = @"No";
//    self.iPopupMenuLeftButtonTitle = @"Yes";
//    self.iPresentViewFlag=TRUE;
//    self.iPopUpViewFlag=TRUE;
//    self.iMobileCXApiKey =apiKey;
//    self.iBaseWindow = aWindow;
//    self.iCurrentScreenName = @"";
//    return self;
//}



-(void)engageTouchPoint:(NSNumber*)aTouchPointID WithViewControllerName:(NSString*)aScreenName {
    NSMutableDictionary *responseInfo = [[NSMutableDictionary alloc]init];
    NSString *userDefaultKey =[NSString stringWithFormat:@"%@%@",self.iTouchPointName,self.iCurrentScreenName];
    if ([self.iBusinessLogicManager checkPreviousResponseForScreen:userDefaultKey]) {
        responseInfo = [self.iBusinessLogicManager getPreviousResponseforKey:userDefaultKey];
        self.iCurrentScreenName = aScreenName;
        NSString *surveyURL = [responseInfo valueForKey:ksurveyURL];
        if (surveyURL != nil && surveyURL.length >0) {
            [self showMessageInViewControllerWithResponse:responseInfo];
            [self.iBusinessLogicManager deletePreviousResponseforKey:userDefaultKey];
        }
    }else {
        [CXServiceTXManager touchPointServiceInvocation:self withTouchPointID:aTouchPointID withAPIKey:self.iCXApiKey];
    }
    

    
}

-(void)touchPointRequestDidFinish:(CXTouchPointServiceAsyncInvocation*)invocation withError:(NSError*)error {
    if (error) {
        NSLog(@"error in response data");
    }else {
        NSMutableDictionary *cxResponse=[[NSMutableDictionary alloc]init];
        cxResponse =[GlobalDataCX getDictFromPList];
        if ([cxResponse valueForKey:ksurveyURL] != nil && ![[cxResponse valueForKey:ksurveyURL] isEqualToString:@"Empty"]) {
            if (!self.iPresentViewFlag) {
                NSString *userDefaultKey =[NSString stringWithFormat:@"%@%@",self.iTouchPointName,self.iCurrentScreenName];
                [self.iBusinessLogicManager addValueToUserDefault:cxResponse ForKey:userDefaultKey];
            }
            [self showMessageInViewControllerWithResponse:cxResponse];
        }
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

-(void)currentViewStateFlag:(BOOL)aViewState {
    self.iPresentViewFlag = aViewState;
}

-(void)showMessageInViewControllerWithResponse:(NSDictionary*)aResponseDict {
    
    BOOL popUpFlag = FALSE;
    NSNumber *isDialog = [aResponseDict valueForKey:kisDialog];
    if ([isDialog intValue] == 1)
        popUpFlag = TRUE;
    else
        popUpFlag = FALSE;
    
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
    headerImage.image=[UIImage imageNamed:@"CXResource.bundle/powered-by02x2x.png"];
    headerImage.contentMode = UIViewContentModeScaleAspectFit;
    [frontView addSubview:headerImage];
    
    self.iWebView=[[UIWebView alloc]initWithFrame:CGRectMake(00,16, frontView.frame.size.width, frontView.frame.size.height-16)];
    self.iWebView.delegate=self;
    NSURL *nsurl=[NSURL URLWithString:[aResponseDict valueForKey:ksurveyURL]];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.iWebView setBackgroundColor:[UIColor clearColor]];
    [self.iWebView loadRequest:nsrequest];
    [frontView addSubview:self.iWebView];
    
    [self.iView addSubview:frontView];
    [self.iBaseWindow addSubview:self.iView];
    [self.iBaseWindow bringSubviewToFront:self.iView];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton addTarget:self action:@selector(aDismissWebview:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *closeButtonImage = [UIImage imageNamed:@"CXResource.bundle/close-button_2.png"];
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
    [GMDCircleLoader hideFromView:self.iWebView animated:YES];
}

-(void)aDismissWebview:(id)sender {
    if (self.iView) {
        [self.iView removeFromSuperview];
    }
}


@end
