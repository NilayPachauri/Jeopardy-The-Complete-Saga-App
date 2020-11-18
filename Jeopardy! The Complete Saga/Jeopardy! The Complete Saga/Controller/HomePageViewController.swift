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
        
        // Get the Current Font Size for the Trivia Gauntlet Label
//        let fontSize = Utility.getApproximateAdjustedFontSizeWithLabel(label: self.triviaGauntletLabel) * 2
        let triviaGauntletFontSize = Utility.getApproximateMaximumFontSizeThatFitsButton(button: self.triviaGauntletButton)
        let customGameFontSize = Utility.getApproximateMaximumFontSizeThatFitsButton(button: self.customGameButton)
       
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
        
        let borderWidth: CGFloat = 2
        let borderColor: CGColor = UIColor.link.cgColor
        let cornerRadius: CGFloat = 5
        
        //  Add Border around Trivia Gauntlet Button Label
        if let label = self.triviaGauntletButton.titleLabel {
            label.layer.borderWidth = borderWidth
            label.layer.borderColor = borderColor
            label.layer.cornerRadius = cornerRadius
        }
        //  Add Border around Custom Game Button Label
        if let label = self.customGameButton.titleLabel {
            label.layer.borderWidth = borderWidth
            label.layer.borderColor = borderColor
            label.layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: Functions to Segue to Other Views
    

    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        // TODO: Segue into Settings View
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        // TODO: Segue into Info View
    }

}

