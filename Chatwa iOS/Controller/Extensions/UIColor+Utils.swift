//
//  UIColor+Utils.swift
//  Chatwa iOS
//
//  Created by Javon on 7/5/17.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static let letterColor = UIColor(hexValue: 0x40B320)
    static let letterBackground = UIColor(hexValue: 0xAAC9A2)
    static let pattiesBackground = UIColor(hexValue: 0x397D02)
    static let pattiesLetterColor = UIColor.white
    static let roundNumberColor = UIColor.white
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hexValue:Int) {
        self.init(red:(hexValue >> 16) & 0xff, green:(hexValue >> 8) & 0xff, blue:hexValue & 0xff)
    }
    
}
