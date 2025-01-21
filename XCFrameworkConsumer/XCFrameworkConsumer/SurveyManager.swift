import UIKit
import QuestionProCXFramework

@MainActor
class SurveyManager {
    static let shared = SurveyManager()

    private init() {}
    public var iQuestionProCXManager = QuestionProCXManager.sharedManager
    let touchPoint = TouchPoint()

    func initializeSurvey(window: UIWindow, showInDialog: Bool) {
        let apiKey = "5e706b2b-dd69-4df5-bcf9-1fd9190854ad"
        let surveyId = 12174640

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
        touchPoint.transactionLanguage = "English"

        iQuestionProCXManager.launchFeedbackSurvey(touchPoint: touchPoint)
    }
}
