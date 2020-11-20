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
    @IBOutlet weak var customGameButton: UIButton!
    
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
        self.customGameButton.titleEdgeInsets = titleEdgeInsets
        
        // Get the Current Font Size for the Trivia Gauntlet Label
        let triviaGauntletFontSize = ViewControllerUtility.getApproximateMaximumFontSizeThatFitsButton(button: self.triviaGauntletButton, border: true)
        let customGameFontSize = ViewControllerUtility.getApproximateMaximumFontSizeThatFitsButton(button: self.customGameButton, border: true)
       
        // Update the Font Size for the Buttons
        self.triviaGauntletButton.titleLabel?.font = self.triviaGauntletButton.titleLabel?.font.withSize(triviaGauntletFontSize)
        self.customGameButton.titleLabel?.font = self.customGameButton.titleLabel?.font.withSize(customGameFontSize)
        
        // Let the Max be the FontSize for the Other Buttons
        let fontSize = max(triviaGauntletFontSize, customGameFontSize)
        
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
        
        //  Add Border around Custom Game Button
        self.customGameButton.layer.borderWidth = borderWidth
        self.customGameButton.layer.borderColor = borderColor
        self.customGameButton.layer.cornerRadius = cornerRadius
    }
    
    // MARK: - Storyboard Navigation
    @IBAction func unwindToHomePage(segue: UIStoryboardSegue) {}
}

