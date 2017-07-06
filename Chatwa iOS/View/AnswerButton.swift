//
//  AnswerButton.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 03/06/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit

@IBDesignable class AnswerButton: LetterButton {
    
    
    override public var intrinsicContentSize: CGSize { // Need to override this to size the button within the StackView
        get {
            // Calculate dimension by using the width of the screen 
            // - padding(16) 
            // - space to be accounted for during spacing of the letters (maxLetters-1 * 5) since there is a spacing of 5 on the stackview
            let totalSpace = (self.window?.frame.width)! - 16 - CGFloat(((Constants.Values.maxLettersInAnswer - 1) * 5))
            let dimension = totalSpace/CGFloat(Constants.Values.maxLettersInAnswer)
            return CGSize(width: dimension, height: dimension)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setDefaultColor()
    }
    
    func setDefaultColor() {
        self.setTitleColor(.black, for: .normal)
    }
    
    func setWrongAnswerColor() {
        self.setTitleColor(.red, for: .normal)
    }
}
