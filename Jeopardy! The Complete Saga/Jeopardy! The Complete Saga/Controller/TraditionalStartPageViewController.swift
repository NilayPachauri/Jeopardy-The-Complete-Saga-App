//
//  TraditionalStartPageViewController.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/20/20.
//

import UIKit

class TraditionalStartPageViewController: UIViewController {

    
    @IBOutlet weak var numberOfCategoriesTextField: UITextField!
    @IBOutlet weak var numberOfCategoriesSlider: UISlider!
    @IBOutlet weak var jeopardyRoundSwitch: UISwitch!
    @IBOutlet weak var doubleJeopardyRoundSwitch: UISwitch!
    @IBOutlet weak var finalJeopardyRoundSwitch: UISwitch!
    @IBOutlet weak var minutesPerRoundTextField: UITextField!
    @IBOutlet weak var minutesPerRoundStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
