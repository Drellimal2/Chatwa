//
//  UIView+Utils.swift
//  Chatwa iOS
//
//  Created by QualityWorks on 7/5/17.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setCornerRadius(radius: Int) {
        self.layer.cornerRadius = CGFloat(radius)
    }
    
    func setDefaultCornerRadius() {
        self.layer.cornerRadius = CGFloat(Values.defaultRadius)
    }
    
}
