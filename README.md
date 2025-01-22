
## How to add QuestionPro’s SDK to your iOS app

### Add the below line to your apps podfile and do install the pod.

  `pod 'QuestionProCXFramework', :git => 'https://github.com/surveyanalyticscorp/ios-cx.git'`<br /><br /><br />



  
## Configure the SDK into your iOS application. 
### A: If the host application is using simple AppDelegate 
You can do the SDK initialisation part in the ‘AppDelegate’ class and then call the ‘launch survey’ wherever you want to launch the survey.
1. Import the SDK into your application.
2. Initialize the SDK variables.
3. Configure the SDK into your app. You have set the **API key** and **Datacenter** while configuring the SDK. QuestionPro’s account manager will provide you with those details.
4. Launch the survey - You need to compose the ‘TouchPoint’ object which contains the **SurveyId** - required field and other optional fields like email, first name, last name, mobile number, and custom variables up to 3.<br /><br /><br />



### B: If the host application is using UIWindowSceneDelegate
You can set up the SDK initialisation part in the ‘UIWindowSceneDelegate’ class and then call the ‘launch survey’ wherever you want to launch the survey.
1. Import the SDK into your application.
2. Initialize the SDK variables.
3. Configure the SDK into your app. You have set the **API key** and **Datacenter** while configuring the SDK. QuestionPro’s account manager will provide you with those details.
4. Launch the survey: You need to compose the ‘TouchPoint’ object which contains the **SurveyId** - mandatory field and other optional fields like email, first name, last name, mobile number, and custom variables up to 3.

