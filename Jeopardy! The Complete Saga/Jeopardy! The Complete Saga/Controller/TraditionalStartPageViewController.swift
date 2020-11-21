//
//  TraditionalStartPageViewController.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/20/20.
//

import UIKit

class TraditionalStartPageViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlet Declarations
    @IBOutlet weak var numberOfCategoriesTextField: UITextField!
    @IBOutlet weak var numberOfCategoriesSlider: UISlider!
    @IBOutlet weak var jeopardyRoundSwitch: UISwitch!
    @IBOutlet weak var doubleJeopardyRoundSwitch: UISwitch!
    @IBOutlet weak var finalJeopardyRoundSwitch: UISwitch!
    @IBOutlet weak var minutesPerRoundTextField: UITextField!
    @IBOutlet weak var minutesPerRoundStepper: UIStepper!
    
    // MARK: - ViewController Lifecyle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupDelegates()
        self.setupUIValues()
        self.setupToHideKeyboardOnTapOnView()
    }
    
    func setupDelegates() {
        // Assign Delegates
        self.numberOfCategoriesTextField.delegate = self
        self.minutesPerRoundTextField.delegate = self
    }
    
    func setupUIValues() {
        // Set Up the Number of Categories Components
        self.numberOfCategoriesTextField.text = "3"
        self.numberOfCategoriesSlider.value = 3.0
        
        // Set Up the Minutes Per Round Components
        self.minutesPerRoundTextField.text = "5"
        self.minutesPerRoundStepper.value = 5.0
    }
    
    // MARK: - Functions to Control View
    @IBAction func numberOfCategoriesTextFieldEditingDidEnd(_ sender: UITextField) {
        if let value = self.numberOfCategoriesTextField.text {
            if let intValue = Int(value)  {
                if intValue > 0 && intValue <= 6 {
                    self.numberOfCategoriesSlider.value = Float(intValue)
                }
            }
            
            // In the event it was a non-parseable String or  not within the bounds, reset text
            self.numberOfCategoriesTextField.text = String(format: "%d", getIntegerValueFromSlider(slider: self.numberOfCategoriesSlider))
        }
    }
    
    @IBAction func numberOfCategoriesSliderValueChanged(_ sender: UISlider) {
        // Get the new value from the Slider
        let value = getIntegerValueFromSlider(slider: self.numberOfCategoriesSlider)
        
        // Update the Text Field
        self.numberOfCategoriesTextField.text = String(format: "%d", value)
    }
    
    @IBAction func minutesPerRoundTextFieldEditingDidEnd(_ sender: UITextField) {
        if let value = self.minutesPerRoundTextField.text {
            if let intValue = Int(value)  {
                if intValue > 0 && intValue <= 20 {
                    self.minutesPerRoundStepper.value = Double(intValue)
                }
            }
            
            // In the event it was a non-parseable String or  not within the bounds, reset text
            self.minutesPerRoundTextField.text = String(format: "%d", getIntegerValueFromStepper(stepper: self.minutesPerRoundStepper))
        }
    }
    
    @IBAction func minutesPerRoundStepperValueChanged(_ sender: UIStepper) {
        // Get the new value from the Slider
        let value = getIntegerValueFromStepper(stepper: self.minutesPerRoundStepper)
        
        // Update the Text Field
        self.minutesPerRoundTextField.text = String(format: "%d", value)
    }
    
    // MARK: - Functions to Dismiss Keyboard
    
    // Done on Text Field should dismiss Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.numberOfCategoriesTextField {
            self.numberOfCategoriesTextField.resignFirstResponder()
        } else if textField == self.minutesPerRoundTextField {
            self.minutesPerRoundTextField.resignFirstResponder()
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
    
    // MARK: - Navigation
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startButtonPressed(_ sender: UIBarButtonItem) {
        print("Start Pressed")
        
        let settings = TraditionalSettings(numOfCategories: getIntegerValueFromSlider(slider: self.numberOfCategoriesSlider), hasJeopardyRound: self.jeopardyRoundSwitch.isOn, hasDoubleJeopardyRound: self.doubleJeopardyRoundSwitch.isOn, hasFinalJeopardyRound: self.finalJeopardyRoundSwitch.isOn, numOfMinutesPerRound: getIntegerValueFromStepper(stepper: self.minutesPerRoundStepper))
        
        var jeopardyClues: [String: [Clue]] = [:]
        var doubleJeopardyClues: [String: [Clue]] = [:]
        var finalJeopardyClue: Clue? = nil
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
