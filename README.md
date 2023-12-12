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
Please refer to the screens: [Screenshot1](https://app.screencast.com/ZWgPjcdG9pf7U), [Screenshot2](https://app.screencast.com/cUIpqDPyp6bRl)

Second add libmobileCX_Library.a file to 'Link Binary With Libraries' section in target 'Build Phases' setting.<br>
Please refer to the screencast: [Screenshot1](https://app.screencast.com/fDs7Lr8h3YPFJ), [Screenshot2](https://app.screencast.com/xTTbmOLoYFnUi)


Finally add mobileCX_Resource.bundle file to 'Copy Bundle Resource' section in target 'Build Phases' setting. <br>
Please refer to the screencast: [Screenshot](https://app.screencast.com/qb0lNBAGKPGCh)

### For Objective-C project

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
    `[[SurveyAnalyticsAppDelegate sharedAppDelegate].iMobileCX_Library engageTouchPoint:@(115) WithViewControllerName:@"ListView"]` <br><br>


### For Swift project
Step 1:<br>
    Once the library is installed, we need to create a new bridging header file inside the Swift project (you can learn more about the Bridging Header file [here](https://developer.apple.com/documentation/swift/importing-objective-c-into-swift#). <br>
    To add a bridging header file we need to right-click on the main project file from the project navigator, and then select New File. Once clicked, we need to select Header File. After this, we need to provide a suitable name to the Header file eg. **cx-library-bridging-header.h** [Screenshot](https://app.screencast.com/dYeqxWKGoDf3e).

Step 2:<br>
    Once the bridging header file is created, we need to add the below import in it.<br>
    `#import <MobileCX_Library/MobileCX_Library.h>`.


 Step 3:<br>
    Now, open the AppDelegate.swift file. Create an object for MobileCX_Library like below:
    `var mobileCXLibObj = MobileCX_Library()`,<br> 
    Now in the application method of AppDelegate.swift file add the below line:
    `mobileCXLibObj.initwithAPIKey("895cfa3d-a044-4d86-9352-c3e86e6dfeeb", with: window)`

 Step 4: <br>
    Now, open the ViewController.swift file. In this file create a reference to the **AppDelegate** <br>
    `let appDelegate = UIApplication.shared.delegate as! AppDelegate`.<br>
    Now in the overridden `viewDidLoad()` method using appDelegate reference we need to execute the **engageTouchPoint**  method of **MobileCX_Library**. <br>
    `appDelegate.mobileCXLibObj.engageTouchPoint(8092755, withViewControllerName: "DemoLaunchView")`
   

