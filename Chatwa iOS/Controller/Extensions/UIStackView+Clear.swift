//
//  UIStackView+Clear.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 7/8/17.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    func clear() {
        for view in self.arrangedSubviews {
            self.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
