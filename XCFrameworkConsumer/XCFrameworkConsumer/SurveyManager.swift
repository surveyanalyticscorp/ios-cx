import UIKit
import QuestionProCXFramework

class SurveyManager {
    static let shared = SurveyManager()

    private init() {}
    public var iQuestionProCXManager = QuestionProCXManager.sharedManager
    let touchPoint = TouchPoint()

    func initializeSurvey(window: UIWindow) {
        let apiKey = "REPLACE_WITH_YOUR_WORKSPACE_API_KEY"
        let surveyId = 1111

        iQuestionProCXManager.initwithAPIKey(
            apiKey: apiKey,
            dataCenter: TouchPoint.DataCenter.DATA_CENTER_US,
            withWindow: window
        )

        let touchPoint = touchPoint.initTouchPoint(surveyId: surveyId)
        touchPoint.firstName = "Prasad"
        touchPoint.lastName = "Bhide"
        touchPoint.customVariable1 = "Pune"
        touchPoint.customVariable2 = "India"
        touchPoint.customVariable3 = "Wakad"

        iQuestionProCXManager.launchFeedbackSurvey(touchPoint: touchPoint)
    }
}
