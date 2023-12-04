# iOS-cx
   Minimum iOS Version: 9.0

#### Including MobileCX_Lib into your project.
            OR
#### Include “MobileCX” as a subproject in your project.

##### User need to include below three files in his project:
          1) libmobileCX_Library.a
          2) MobileCX_Resource.bundle
          3) mobileCX_Library.h


First add mobileCX_Library.a and mobileCX_Resource.bundle file to 'Target Dependencies' section  in target 'Build Phases' setting.<br>
Please refer to the screens: [Screenshot1](https://app.screencast.com/ZWgPjcdG9pf7U){:target="_blank"}, [Screenshot2](https://app.screencast.com/cUIpqDPyp6bRl){:target="_blank"}

Second add libmobileCX_Library.a file to 'Link Binary With Libraries' section in target 'Build Phases' setting.<br>
Please refer to the screencast: [Screenshot1](https://app.screencast.com/fDs7Lr8h3YPFJ){:target="_blank"}, [Screenshot2](https://app.screencast.com/xTTbmOLoYFnUi){:target="_blank"}


Finally add mobileCX_Resource.bundle file to 'Copy Bundle Resource' section in target 'Build Phases' setting. <br>
Please refer to the screencast: [Screenshot](https://app.screencast.com/qb0lNBAGKPGCh){:target="_blank"}

Step 1:
    Go to AppDelegate.h file and copy following lines:

   `#import<MobileCX_Library/MobileCX_Library.h>` <br>
   `@property (strong, nonatomic) MobileCX_Library *iMobileCX_Library;
    + (AppDelegate *)sharedAppDelegate;`

Step 2:
    Copy the below mentioned line in AppDelegate didFinishLaunchingWithOptions method:

`self.iMobileCX_Library = [[MobileCX_Library alloc]` <br> `initwithAPIKey:@"87f682bb-bab3-4099-b7e9-da8779bba6b0" withWindow:self.iWindow];`


 Step 3:
    Don’t forget to include shared method in AppDelegate.m file:

`(AppDelegate *)sharedAppDelegate {`<br>
        `return (AppDelegate *)[UIApplication sharedApplication].delegate;` <br>
`}`

 Step 4: 
    To integrate touchpoint for particular event, copy the below mentioned lines:<br>
    `[[SurveyAnalyticsAppDelegate sharedAppDelegate].iMobileCX_Library engageTouchPoint:@(115) WithViewControllerName:@"ListView"]`
