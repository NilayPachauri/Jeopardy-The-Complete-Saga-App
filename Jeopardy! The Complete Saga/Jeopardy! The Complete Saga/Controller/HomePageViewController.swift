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
        setupLabelBorders()
    }
    
    // MARK: Functions to Initialize View
    
    func setupButtonSizes() {
        // Inset the Buttons
        let titleEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        self.triviaGauntletButton.titleEdgeInsets = titleEdgeInsets
        self.customGameButton.titleEdgeInsets = titleEdgeInsets
        
        // Get the Current Font Size for the Trivia Gauntlet Label
        let triviaGauntletFontSize = Utility.getApproximateMaximumFontSizeThatFitsButton(button: self.triviaGauntletButton, border: true)
        let customGameFontSize = Utility.getApproximateMaximumFontSizeThatFitsButton(button: self.customGameButton, border: true)
       
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

    func setupLabelBorders() {
        
        let borderWidth: CGFloat = 3
        let borderColor: CGColor = UIColor.link.cgColor
        let cornerRadius: CGFloat = 25
        
        //  Add Border around Trivia Gauntlet Button Label
        self.triviaGauntletButton.layer.borderWidth = borderWidth
        self.triviaGauntletButton.layer.borderColor = borderColor
        self.triviaGauntletButton.layer.cornerRadius = cornerRadius
        
        //  Add Border around Custom Game Button Label
        self.customGameButton.layer.borderWidth = borderWidth
        self.customGameButton.layer.borderColor = borderColor
        self.customGameButton.layer.cornerRadius = cornerRadius
    }
    
    // MARK: Functions to Segue to Other Views
    

    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        // TODO: Segue into Settings View
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        // TODO: Segue into Info View
    }

}

