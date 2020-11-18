//
//  TriviaGauntletStartPageViewController.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/17/20.
//

import UIKit

class TriviaGauntletStartPageViewController: UIViewController {

    @IBOutlet weak var triviaGauntletLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var startLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBorders()
    }
    
    // MARK: - Function to Set Up View
    func setupBorders() {
        self.startLabel.layer.borderWidth = 3
        self.startLabel.layer.borderColor = UIColor.link.cgColor
        self.startLabel.layer.cornerRadius = 15
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
