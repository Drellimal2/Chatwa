//
//  Constants.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 31/05/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct StaticText {
        static let instructionsTitle = "Instructions"
        static let instructionsMessage = "Think you know your Jamaican Patois? Click the letter tiles at the bottom to fill in all the empty slots. When you've filled them all if they match the answer then hoorah! You've got it right. You get a free Patty for every correct word and you can also use patties to see get hints on the answer! Press play to get started!"
        static let instructionsDismissText = "Irie!"
    }

    struct DummyData {
        static let hint = "A young boy"
        static let answer = "BWOY"
        static let grid = "AVBSBSJKOLWYMK"
    }
    
    struct SegueIdentifiers {
        static let game = "showGame"
    }
    
    struct Values {
        static let defaultRadius = 6
        static let lettersInRow = 7
        static let maxLettersInAnswer = 11
        static let correctTransitionViewAlpha = 0.25
    }
}

enum ServerInstance {
    case local
    case development
    case production
}


enum ServerError: Error {
    case invalidPath
}


struct API {
    static var shared = API()
    let localPath = "http://localhost:8000/"
    let developmentPath = ""
    let productionPath = ""
    
    var basePath:String!
    
    mutating func use(instance: ServerInstance) {
        switch instance {
        case .local:
            basePath = localPath
        case .development:
            basePath = developmentPath
        case .production:
            basePath = productionPath
        }
    }
    
    func rounds() -> String {
        return basePath + "rounds"
    }
}
