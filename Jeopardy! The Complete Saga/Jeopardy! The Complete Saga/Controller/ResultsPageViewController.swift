//
//  ResultsPageViewController.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/20/20.
//

import UIKit

class ResultsPageViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var resultsLabel: UILabel!
    
    // MARK: - ViewController Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.makeNavigationBarTransparent()
        self.setResultsLabel()
    }
    
    // MARK: - Functions to Set Up View
    func makeNavigationBarTransparent() {
        
    }
    
    func setResultsLabel() {
        self.resultsLabel.text = String(format: "You got %d out of %d correct!", TriviaGauntletGame.shared.getScore(), TriviaGauntletGame.shared.getNumberOfClues())
    }
    
    // MARK: - Storyboard Navigation
    @IBAction func playAgainButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "UnwindToTriviaGauntletStartPage", sender: self)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "UnwindToHomePage", sender: self)
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
