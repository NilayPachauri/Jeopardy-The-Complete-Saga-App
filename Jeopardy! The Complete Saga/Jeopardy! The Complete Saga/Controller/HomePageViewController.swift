//
//  HomePageViewController.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/17/20.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var triviaGauntletButton: UIButton!
    @IBOutlet weak var traditionalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupButtonSizes()
        setupButtonBorders()
    }
    
    // MARK: Functions to Initialize View
    
    func setupButtonSizes() {
        // Inset the Buttons
        let titleEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.triviaGauntletButton.titleEdgeInsets = titleEdgeInsets
        self.traditionalButton.titleEdgeInsets = titleEdgeInsets
        
        // Get the Current Font Size for the Trivia Gauntlet Label
        let triviaGauntletFontSize = ViewControllerUtility.getApproximateMaximumFontSizeThatFitsButton(button: self.triviaGauntletButton, border: true)
        let traditionalFontSize = ViewControllerUtility.getApproximateMaximumFontSizeThatFitsButton(button: self.traditionalButton, border: true)
        let fontSize = min(triviaGauntletFontSize, traditionalFontSize)
       
        // Update the Font Size for the Buttons
        self.triviaGauntletButton.titleLabel?.font = self.triviaGauntletButton.titleLabel?.font.withSize(fontSize)
        self.traditionalButton.titleLabel?.font = self.traditionalButton.titleLabel?.font.withSize(fontSize)
        
        // Create the Symbol Configuration
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: fontSize)
        
        // Resize the Buttons
        self.settingsButton.setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)
        self.infoButton.setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)
    }

    func setupButtonBorders() {
        
        let borderWidth: CGFloat = 3
        let borderColor: CGColor = UIColor.link.cgColor
        let cornerRadius: CGFloat = 25
        
        //  Add Border around Trivia Gauntlet Button
        self.triviaGauntletButton.layer.borderWidth = borderWidth
        self.triviaGauntletButton.layer.borderColor = borderColor
        self.triviaGauntletButton.layer.cornerRadius = cornerRadius
        
        //  Add Border around Traditional Button
        self.traditionalButton.layer.borderWidth = borderWidth
        self.traditionalButton.layer.borderColor = borderColor
        self.traditionalButton.layer.cornerRadius = cornerRadius
    }
    
    // MARK: - Storyboard Navigation
    @IBAction func unwindToHomePage(segue: UIStoryboardSegue) {}
}

