//
//  LetterButton.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 01/06/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit

@IBDesignable class LetterButton: UIButton {

    @IBInspectable var borderColor: UIColor = .white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    func setletter(letter: String) {
        self.titleLabel?.text = letter
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.isUserInteractionEnabled = true
        self.backgroundColor = .letterBackground
        self.setDefaultCornerRadius()
        clipsToBounds = true
    }

}
