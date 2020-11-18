//
//  TriviaGauntletStartPageViewController.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/17/20.
//

import UIKit

class TriviaGauntletStartPageViewController: UIViewController {

    @IBOutlet weak var startLabel: UILabel!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBorders()
    }
    
    // MARK: - Functions to Set Up View
    func setupBorders() {
        self.startLabel.layer.borderWidth = 3
        self.startLabel.layer.borderColor = UIColor.link.cgColor
        self.startLabel.layer.cornerRadius = 15
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
