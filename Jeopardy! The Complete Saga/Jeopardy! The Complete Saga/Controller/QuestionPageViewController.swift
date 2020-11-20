//
//  QuestionPageViewController.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/17/20.
//

import UIKit

class QuestionPageViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlet Class Attributes
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var microphoneButton: UIButton!
    
    // MARK: - Public Class Attributes
    public var gameMode: GameMode = .TRIVIA_GAUNTLET
    
    // MARK: - Private Class Attributes
    private let timerInterval: TimeInterval = 0.1
    private var timerLeft: Double = 0
    private var timer: Timer? = nil
    private var userAnswer: String = ""
    
    // MARK: - ViewController Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set Up Dismiss Keyboard
        self.answerTextField.delegate = self
        self.setupToHideKeyboardOnTapOnView()
        self.setupMoveUpScreenIfKeyboardPresent()
        
        // Set Up Content
        self.setAnswerTextFieldFont()
        self.setMicrophoneButtonSize()
        self.setupClue()
    }
    
    // MARK: Functions to Set Up View
    func setAnswerTextFieldFont() {
        
        // Get the Font from the Answer Label
        let font = UIFont(name: self.answerTextField.font?.fontName ?? "Swiss  911", size: ViewControllerUtility.getApproximateAdjustedFontSizeWithLabel(label: self.answerLabel))
        
        // Set the Answer Text Field Font
        self.answerTextField.font = font
    }
    
    func setMicrophoneButtonSize() {
         
        // Get the Font Size from the Answer Label
        let fontSize = ViewControllerUtility.getApproximateAdjustedFontSizeWithLabel(label: self.answerLabel) * 2
        
        // Define Symbol Configuration
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: fontSize)
        
        // Set the Symbol Configuration for the Microphone Button
        self.microphoneButton.setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)
    }
    
    // MARK: - Functions to Set Up New Question
    func setupClue() {
        self.setupTimer()
        self.setupScore()
        self.updateLabelsToCurrentClue()
    }
    
    func setupTimer() {
        // Initialize Timer to 15 seconds
        self.timerLeft = 15.0
        self.timer = Timer.scheduledTimer(timeInterval: self.timerInterval, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
    }
    
    func setupScore() {
        // Set Score Label
        self.scoreLabel.text = String(format: "Score: %d", TriviaGauntletGame.shared.getScore())
    }
    
    func updateLabelsToCurrentClue() {
        // Get the Current Clue
        if let clue = TriviaGauntletGame.shared.getCurrentClue(){
            
            // Set the Clue information
            self.categoryLabel.text = clue.getCategory()
            self.questionLabel.text = clue.getQuestion()
        }
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
    
    // MARK: - Keyboard Functions
    
    // Done on Number of Questions Text Field should dismiss Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.answerTextField {
            self.answerTextField.resignFirstResponder()
            self.initiateSegueToAnswerPage(userAnswer: self.answerTextField.text ?? "")
        }
        
        return true
    }
    
    // Tap outside should dismiss keyboard
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func setupMoveUpScreenIfKeyboardPresent() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    // MARK: - Navigation
    
    func initiateSegueToAnswerPage(userAnswer: String) {
        self.userAnswer = userAnswer
        if let timer = self.timer {
            timer.invalidate()
        }
        performSegue(withIdentifier: "AnswerGivenSegue", sender: self)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AnswerGivenSegue" {
            if let answerVC = segue.destination as? AnswerPageViewController {
                
                // Get the Current Clue
                if let clue = TriviaGauntletGame.shared.getCurrentClue() {
                
                    // Set Information
                    answerVC.timer = self.timerLeft
                    answerVC.userAnswer = self.userAnswer
                    
                    // Determine if the User is Correct
                    answerVC.response = answerVC.userAnswer == clue.getAnswer()
                    if answerVC.response {
                        TriviaGauntletGame.shared.incrementScore()
                    }
                }
            }
        }
    }
    

}
