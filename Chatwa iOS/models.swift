//
//  models.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 05/06/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation

struct Round {
    var hint: String!
    var answer: String!
    var grid: String!
    
    init(hint: String, answer: String, grid: String) {
        self.hint = hint
        self.answer = answer
        self.grid = grid
    }
}
