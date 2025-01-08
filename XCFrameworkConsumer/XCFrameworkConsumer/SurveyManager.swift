import UIKit
import QuestionProCXFramework

class SurveyManager {
    static let shared = SurveyManager()

    private init() {}
    public var iQuestionProCXManager = QuestionProCXManager.sharedManager
    let touchPoint = TouchPoint()

    func initializeSurvey(window: UIWindow) {
        let apiKey = "74522d0e-b4a0-442b-abfd-b2d39dfa8dcc"
        let surveyId = 12658890

        iQuestionProCXManager.initwithAPIKey(
            apiKey: apiKey,
            dataCenter: TouchPoint.DataCenter.DATA_CENTER_EU,
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
