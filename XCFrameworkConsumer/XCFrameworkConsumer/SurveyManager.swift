import UIKit
import QuestionProCXFramework

@MainActor
class SurveyManager {
    static let shared = SurveyManager()

    private init() {}
    public var iQuestionProCXManager = QuestionProCXManager.sharedManager
    let touchPoint = TouchPoint()

    func initializeSurvey(window: UIWindow, showInDialog: Bool) {
        let apiKey = "04d4d48a-37b9-4c08-8638-9b50744ac32e"
        let surveyId = 6927573

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
        touchPoint.ShowInDialog = showInDialog

        iQuestionProCXManager.launchFeedbackSurvey(touchPoint: touchPoint)
    }
}
