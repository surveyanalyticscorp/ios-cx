//
//  ViewController.swift
//  XCFrameworkConsumer
//
//  Created by Prasad on 30/07/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var popupSurveyButton: UIButton?
    @IBOutlet weak var fullScreenSurveyButton: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func popupSurveyButtonTouchUpInside(_sender: Any) {
        let window = AppDelegate.shared.window!
        SurveyManager.shared.initializeSurvey(window: window, showInDialog: true)
    }
    
    @IBAction func fullScreenSurveyButtonTouchUpInside(_sender: Any) {
        let window = AppDelegate.shared.window!
        SurveyManager.shared.initializeSurvey(window: window, showInDialog: false)
    }
}

