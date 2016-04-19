# iOS-cx
   Minimum iOS Version: 7.1

#### Including MobileCX_Lib into your project.
            OR
#### Include “MobileCX” as a subproject in your project.

##### User need to include below three files in his project:
          1) libmobileCX_Library.a
          2) mobileCX_Resource.bundle
          3) mobileCX_Library.h


First add mobileCX_Library.a & mobileCX_Resource.bundle file to “target dependencies” section  in target build phase setting. Please refer to the screencast: http://screencast.com/t/tpgyWlim

Second add libmobileCX_Library.a file to “link binary with libraries” section in target build phase setting. Please refer to the screencast : http://screencast.com/t/Xuir9o2Nm


Finally add mobileCX_Resource.bundle file to “copy bundle resource” section in target build phase setting. Please refer to the screencast: http://screencast.com/t/vAqxluGSD

Step 1). Now go to AppDelegate.h file and copy following lines

    #import<MobileCX_Library/MobileCX_Library.h>  
   @property (strong, nonatomic) MobileCX_Library *iMobileCX_Library;
    + (AppDelegate *)sharedAppDelegate;

Step 2). Copy the below mentioned line in AppDelegate didFinishLaunchingWithOptions method

self.iMobileCX_Library = [[MobileCX_Library alloc]initwithAPIKey:@"87f682bb-bab3-4099-b7e9-da8779bba6b0" withWindow:self.iWindow];


 Step 3). Don’t forget to include shared method in AppDelegate.m file

+ (AppDelegate *)sharedAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

 Step 4). To integrate touchpoint for particular event, copy the below mentioned lines:

    [[SurveyAnalyticsAppDelegate sharedAppDelegate].iMobileCX_Library engageTouchPoint:@(115) WithViewControllerName:@"ListView"];

