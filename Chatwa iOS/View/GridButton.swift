//
//  HintButton.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 03/06/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit

@IBDesignable class GridButton: LetterButton {
    
    var dimension: CGFloat {
        get {
            // Calculate dimension by using the smaller of the width/height of the screen
            // - padding(16)
            // - space to be accounted for during spacing of the letters (maxLetters-1 * 5) since there is a spacing of 5 on the stackview
            let totalSpace = min((self.window?.frame.width)!, (self.window?.frame.height)!) - 16 - CGFloat(((Constants.Values.lettersInRow - 1) * 5))
            return totalSpace/CGFloat(Constants.Values.lettersInRow)
        }
    }
    
    override public var intrinsicContentSize: CGSize { return CGSize(width: dimension, height: dimension) }// Need to override this to size the button within the StackView return
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setDefaultColor()
        setDefaultFont()
    }
    
    func setDefaultColor() {
        self.setTitleColor(.letterColor, for: .normal)
    }
    
    func setDefaultFont() {
        let roundedDimension = CGFloat(Int(dimension) - 5) // Compute a suitable text size
        titleLabel?.font = UIFont(name: "Chalkboard SE", size: roundedDimension)
        titleLabel?.textAlignment = .center
    }
}
