//
//  Constants.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 31/05/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation
import UIKit

struct StaticText {
    static let instructionsTitle = "Instructions"
    static let instructionsMessage = "Think you know your Caribbean patois? Click the letter tiles to fill the slots and guess the word based on the hint. You get a patty for every correct word and you can use patties to buy a letter. Press play to get started!"
    static let instructionsDismissText = "Irie!"
}

struct SegueIdentifiers {
    static let game = "showGame"
}

struct Values {
    static let defaultRadius = 6
}

struct Colors {
    static let letterColor = UIColor(hexValue: 0x40B320)
    static let letterBackground = UIColor(hexValue: 0xAAC9A2)
    static let pattiesBackground = UIColor(hexValue: 0x397D02)
    static let pattiesLetterColor = UIColor.white
    static let roundNumberColor = UIColor.white
}
