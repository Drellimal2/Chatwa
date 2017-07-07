//
//  DataManager.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 12/06/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class DataManager {
    static var shared = DataManager()
    
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    
    func loadRounds() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let _wordsRef = ref.child("words")
        _wordsRef.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let child = child as! DataSnapshot
                let id = Int(child.key)!
                if let child = child.value as? NSDictionary {
                    let hint = child["hint"] as! String
                    let grid = child["grid"] as! String
                    let answer = child["answer"] as! String
                    
                    print("\(id) - \(hint) - \(grid) - \(answer)")
                    _ = Round(id: id, hint: hint, answer: answer, grid: grid, context: appDelegate.coreDataStack.context) // Save the round
                }
            }
            
        })
    }
}
