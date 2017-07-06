//
//  AwohButton.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 05/06/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit

class AwohButton: UIButton {

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
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .letterColor
        setDefaultCornerRadius()
        clipsToBounds = true
    }
}
