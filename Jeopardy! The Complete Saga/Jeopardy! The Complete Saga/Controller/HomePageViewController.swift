//
//  HomePageViewController.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/17/20.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var triviaGauntletLabel: UILabel!
    @IBOutlet weak var customGameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTapGestureRecognizers()
        setupLabelBorders()
    }
    
    // MARK: Functions to Initialize View
    func setupTapGestureRecognizers() {
        
        // Add Tap Gesture Recognizer to Trivia Gauntlet
        let triviaGauntletLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.segueToTriviaGauntletView(_:)))
        self.triviaGauntletLabel.isUserInteractionEnabled = true
        self.triviaGauntletLabel.addGestureRecognizer(triviaGauntletLabelTap)
        
        // Add Tap Gesture Recognizer to Custom Game
        let customGameLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.segueToCustomGameView(_:)))
        self.customGameLabel.isUserInteractionEnabled = true
        self.customGameLabel.addGestureRecognizer(customGameLabelTap)
    }
    
    func setupLabelBorders() {
        //  Add Border around Trivia Gauntlet Label
        self.triviaGauntletLabel.layer.borderWidth = 3
        self.triviaGauntletLabel.layer.borderColor = UIColor.link.cgColor
        self.triviaGauntletLabel.layer.cornerRadius = 25
        
        //  Add Border around Custom Game Label
        self.triviaGauntletLabel.layer.borderWidth = 3
        self.triviaGauntletLabel.layer.borderColor = UIColor.link.cgColor
        self.triviaGauntletLabel.layer.cornerRadius = 25
    }
    
    // MARK: Functions to Segue to Other Views
    
    @objc
    func segueToTriviaGauntletView(_ sender: UITapGestureRecognizer) {
        // TODO: Segue into Trivia Gauntlet View
        print("Label tapped")
    }
    
    @objc
    func segueToCustomGameView(_ sender: UITapGestureRecognizer) {
        // TODO: Segue into Custom Game View
        print("Label tapped")
    }

    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        // TODO: Segue into Settings View
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        // TODO: Segue into Info View
    }

}

