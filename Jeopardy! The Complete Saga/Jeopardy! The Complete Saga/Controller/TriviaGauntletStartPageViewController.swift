//
//  TriviaGauntletStartPageViewController.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/17/20.
//

import UIKit

class TriviaGauntletStartPageViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlet Declarations
    @IBOutlet weak var numberOfQuestionsTextField: UITextField!
    @IBOutlet weak var numberOfQuestionsSlider: UISlider!
    @IBOutlet weak var jeopardyQuestionsSwitch: UISwitch!
    @IBOutlet weak var doubleJeopardyQuestionsSwitch: UISwitch!
    @IBOutlet weak var finalJeopardySwitch: UISwitch!
    @IBOutlet weak var difficulty1QuestionsSwitch: UISwitch!
    @IBOutlet weak var difficulty2QuestionsSwitch: UISwitch!
    @IBOutlet weak var difficulty3QuestionsSwitch: UISwitch!
    @IBOutlet weak var difficulty4QuestionsSwitch: UISwitch!
    @IBOutlet weak var difficulty5QuestionsSwitch: UISwitch!
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.numberOfQuestionsTextField.delegate = self
        
        // Set Up Number of Questions Field
        self.setupNumberOfQuestions()
        
        // Set Up Tap Gesture Recognizer
        self.setupToHideKeyboardOnTapOnView()
        
        // Set Navigation Bar to not Hide Content
        self.edgesForExtendedLayout = []
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    // MARK: - Functions to Set Up View
    
    func setupNumberOfQuestions() {
        self.numberOfQuestionsSlider.value = 5
        self.numberOfQuestionsTextField.text =  "5"
    }
    
    // MARK: - Functions to Control View
    func getIntegerValueFromSlider(slider: UISlider) -> Int {
        var value = slider.value
        value.round()
        
        return Int(value)
    }
    
    @IBAction func numberOfQuestionsSliderValueChanged(_ sender: UISlider) {
        
        // Get the new value from the Slider
        let value = self.getIntegerValueFromSlider(slider: self.numberOfQuestionsSlider)
        
        // Update the Text Field
        self.numberOfQuestionsTextField.text = String(format: "%d", value)
    }
    
    @IBAction func numberOfQuestionsTextFieldEditingDidEnd(_ sender: UITextField) {
        if let value = self.numberOfQuestionsTextField.text {
        if let intValue = Int(value)  {
            if intValue > 0 && intValue <= 100 {
                self.numberOfQuestionsSlider.value = Float(intValue)
            }
        }
        
        // In the event it was a non-parseable String or  not within the bounds, reset text
        self.numberOfQuestionsTextField.text = String(format: "%d", self.getIntegerValueFromSlider(slider: self.numberOfQuestionsSlider))
        }
    }
    
    // MARK: - Functions to Dismiss Keyboard
    
    // Done on Number of Questions Text Field should dismiss Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.numberOfQuestionsTextField {
            self.numberOfQuestionsTextField.resignFirstResponder()
        }
        
        return true
    }
    
    // Tap outside should dismiss keyboard
    func setupToHideKeyboardOnTapOnView()
        {
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
    
    // MARK: - Functions to Handle Navigation Bar Actions
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startButtonPressed(_ sender: UIBarButtonItem) {
        
        let settings = TriviaGauntletSettings(numOfClues: self.getIntegerValueFromSlider(slider: self.numberOfQuestionsSlider), useJeopardyQuestions: self.jeopardyQuestionsSwitch.isOn, useDoubleJeopardyQuestions: self.doubleJeopardyQuestionsSwitch.isOn, useFinalJeopardyQuestions: self.finalJeopardySwitch.isOn, useDifficulty1Questions: self.difficulty1QuestionsSwitch.isOn, useDifficulty2Questions: self.difficulty2QuestionsSwitch.isOn, useDifficulty3Questions: self.difficulty3QuestionsSwitch.isOn, useDifficulty4Questions: self.difficulty4QuestionsSwitch.isOn, useDifficulty5Questions: self.difficulty5QuestionsSwitch.isOn)
        
        var clueList: [Clue] = []
        FirestoreWrapper.getCluesForTriviaGauntlet(triviaGauntletSettings: settings, { (clue) in
            clueList.append(clue)
        }, {
            if clueList.count == settings.numOfClues  {
                TriviaGauntletGame.shared.setClueList(clueList)
                self.performSegue(withIdentifier: "TriviaGauntletSegue", sender: nil)
            }
        })
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "TriviaGauntletSegue" {
            if let questionVC = segue.destination as? QuestionPageViewController {
                questionVC.gameMode = .TRIVIA_GAUNTLET
                questionVC.clueList = self.clueList
            }
        }
    }

}
