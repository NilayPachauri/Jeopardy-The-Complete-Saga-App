//
//  QuestionPageViewController.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/17/20.
//

import UIKit

class QuestionPageViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    
    let timerInterval: TimeInterval = 0.1
    var timerLeft: Double = 0
    var timer: Timer? = nil
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setAnswerTextFieldFont()
        
        // Initialize Values
        self.timerLeft = 10.0
        self.timer = Timer.scheduledTimer(timeInterval: self.timerInterval, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
    }
    
    // MARK: Functions to Set Up View
    func setAnswerTextFieldFont() {
        
        // Get the Font from the Answer Label
        let font = UIFont(name: self.answerTextField.font?.fontName ?? "Swiss  911", size: Utility.getApproximateAdjustedFontSizeWithLabel(label: self.answerLabel))
        
        // Set the Answer Text Field Font
        self.answerTextField.font = font
    }
    
    // MARK: Functions to Set Up Timer
    @objc
    func timerAction() {
        // Decrement Time Left
        self.timerLeft -= self.timerInterval
        
        // Update The Timer Label
        self.timerLabel.text = String(format: "Timer: %3.1f", self.timerLeft)
        
        // Check if time expired
        if self.timerLeft <= 0.01, let timer = self.timer {
            timer.invalidate()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
