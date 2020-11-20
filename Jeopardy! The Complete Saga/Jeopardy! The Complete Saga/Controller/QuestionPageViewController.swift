//
//  QuestionPageViewController.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/17/20.
//

import UIKit
import Speech

class QuestionPageViewController: UIViewController, UITextFieldDelegate, SFSpeechRecognizerDelegate {

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
    
    // MARK: - Private Class Speech Attributes
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
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
        
        // Disable Microphone Button until Authorized
        self.microphoneButton.isEnabled = false
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Configure the SFSpeechRecognizer object already
        // stored in a local member variable.
        speechRecognizer.delegate = self
        
        // Asynchronously make the authorization request.
        SFSpeechRecognizer.requestAuthorization { authStatus in

            // Divert to the app's main thread so that the UI
            // can be updated.
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.microphoneButton.isEnabled = true
                    
                default:
                    self.microphoneButton.isEnabled = false
                }
            }
        }
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
            
            if let userAnswer = self.answerTextField.text {
                self.initiateSegueToAnswerPage(userAnswer: (userAnswer.count > 0) ? userAnswer : "Time Expired")
            } else {
                self.initiateSegueToAnswerPage(userAnswer: "Time Expired")
                
            }
        }
    }
    
    // MARK: - Functions to Handle User Speech
    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode

        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        // Keep speech recognition data on device
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                // Print out the best results
                isFinal = result.isFinal
                print("Text \(result.bestTranscription.formattedString)")
            }
            
            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

                self.microphoneButton.isEnabled = true
            }
        }

        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    @IBAction func microphoneButtonPressed(_ sender: UIButton) throws {
        
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
                    
                    // Reset Text Field
                    self.answerTextField.text = ""
                }
            }
        }
    }
    

}
