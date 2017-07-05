//
//  AnswerButton.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 03/06/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit

@IBDesignable class AnswerButton: LetterButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setDefaultColor() {
        self.setTitleColor(.black, for: .normal)
    }
    
    func setWrongAnswerColor() {
        self.setTitleColor(.red, for: .normal)
    }
}
