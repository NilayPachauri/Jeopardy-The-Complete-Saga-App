//
//  Utility.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/17/20.
//

import UIKit

class Utility {
    static func getApproximateAdjustedFontSizeWithLabel(label: UILabel) -> CGFloat {

        if label.adjustsFontSizeToFitWidth == true {

            var currentFont: UIFont = label.font
            let originalFontSize = currentFont.pointSize
            var currentSize: CGSize = (label.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: currentFont])

            while (currentSize.width > label.frame.size.width || currentSize.height > label.frame.size.height) && currentFont.pointSize > (originalFontSize * label.minimumScaleFactor) {
                currentFont = currentFont.withSize(currentFont.pointSize - 1)
                currentSize = (label.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: currentFont])
            }

            return currentFont.pointSize

        }
        else {

            return label.font.pointSize

        }
    }
    
    static func getApproximateMaximumFontSizeThatFitsButton(button: UIButton)  -> CGFloat {
        
        if let label = button.titleLabel {
        
            var currentFont: UIFont = label.font
            let originalFontSize = currentFont.pointSize
            var currentSize: CGSize = (label.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: currentFont])

            while (currentSize.width > label.frame.size.width || currentSize.height > label.frame.size.height) && currentFont.pointSize > (originalFontSize * label.minimumScaleFactor) {
                currentFont = currentFont.withSize(currentFont.pointSize - 1)
                currentSize = (label.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: currentFont])
            }

            return currentFont.pointSize
        }
        
        return 0
    }
}
