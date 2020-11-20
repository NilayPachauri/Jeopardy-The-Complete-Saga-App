//
//  AnswerPageViewController.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/19/20.
//

import UIKit

class AnswerPageViewController: UIViewController {
    
    // MARK: - IBOutlet Declarations
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var userAnswerStaticLabel: UILabel!
    @IBOutlet weak var userAnswerLabel: UILabel!
    @IBOutlet weak var correctAnswerStaticLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var nextQuestionButton: UIButton!
    
    // MARK: - Public Class Attributes
    public var score: Int = 0
    public var category: String = ""
    public var timer: Double = 0.0
    public var userAnswer: String = ""
    public var correctAnswer: String = ""
    public var response: String = ""
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupLabelContents()
        self.setupLabelFormats()
        self.setupButton()
    }
    
    // MARK: - Functions to Set Up View
    func setupLabelContents() {
        self.scoreLabel.text = String(format: "Score: %d", self.score)
        self.categoryLabel.text = self.category
        self.timerLabel.text = String(format: "Timer: %3.1f", self.timer)
        self.userAnswerLabel.text = self.userAnswer
        self.correctAnswerLabel.text = self.correctAnswer
        self.responseLabel.text = self.response
    }
    
    func setupLabelFormats() {
        // Get the Adjusted Size of Each Label
        let userAnswerFontSize = ViewControllerUtility.getApproximateAdjustedFontSizeWithLabel(label: self.userAnswerStaticLabel)
        let correctAnswerFontSize = ViewControllerUtility.getApproximateAdjustedFontSizeWithLabel(label: self.correctAnswerStaticLabel)
        
        // Create a Custom Font
        let font = UIFont(name: "ITC Korinna Bold", size: min(userAnswerFontSize, correctAnswerFontSize))
        
        // Adjust the font of Static Labels to whoever is smaller
        self.userAnswerStaticLabel.font = font
        self.correctAnswerStaticLabel.font = font
    }
    
    func setupButton() {
        // Inset the Button
        let contentEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        self.nextQuestionButton.contentEdgeInsets = contentEdgeInsets
        
        // Get the Current Font Size for the Next Question Label
        let nextQuestionFontSize = ViewControllerUtility.getApproximateMaximumFontSizeThatFitsButton(button: self.nextQuestionButton, border: true)
       
        // Update the Font Size for the Button Label
        self.nextQuestionButton.titleLabel?.font = self.nextQuestionButton.titleLabel?.font.withSize(nextQuestionFontSize)
        
        // Create the Symbol Configuration
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: nextQuestionFontSize)
        
        // Resize the Button Image
        self.nextQuestionButton.setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)
        
        //  Add Border around Next Question Button
        self.nextQuestionButton.layer.borderWidth = 3
        self.nextQuestionButton.layer.borderColor = UIColor(displayP3Red: 255, green: 204, blue: 0, alpha: 1).cgColor
        self.nextQuestionButton.layer.cornerRadius = 25
    }
    
    // MARK: - Storyboard Navigation
    @IBAction func nextQuestionPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
