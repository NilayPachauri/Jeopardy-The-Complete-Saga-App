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
        setupUIValues()
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
    }
    
    @IBAction func numberOfCategoriesSliderValueChanged(_ sender: UISlider) {
    }
    
    @IBAction func minutesPerRoundTextFieldEditingDidEnd(_ sender: Any) {
    }
    
    @IBAction func minutesPerRoundStepperValueChanged(_ sender: UIStepper) {
    }
    
    // MARK: - Navigation
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
