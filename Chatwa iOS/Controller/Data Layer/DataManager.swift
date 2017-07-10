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
    var rounds = [Round]()
    var isConnected = false
    
    init() {
        ref = Database.database().reference()
        let wordsRef = ref.child("words")
        
        let connectedRef = Database.database().reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { snapshot in
            self.isConnected = snapshot.value as? Bool ?? false
            
            if !self.isConnected {
                wordsRef.removeAllObservers()
            }
            
        })
    }
    
    func loadRounds(localRounds: [Round], completion: @escaping (Bool) -> ()) {
        
        guard isConnected else {
            completion(false)
            return
        }
        
        let roundMap = mapIdsToRounds(rounds: localRounds)
        
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
                    
                    let roundExists = roundMap[id] != nil
                    
                    if !roundExists {
                        _ = Round(id: id, hint: hint, answer: answer, grid: grid, context: appDelegate.coreDataStack.context) // Save the round
                    } else {
                        let round = roundMap[id]
                        if round?.hint != hint {
                            round?.hint = hint
                        }
                        
                        if round?.grid != grid {
                            round?.grid = grid
                        }
                        
                        if round?.answer != answer {
                            round?.answer = answer
                        }
                    }
                    
                }
            }
            completion(true)
            
        })
        
        let _connectedRef = Database.database().reference(withPath: ".info/connected")
        _connectedRef.observe(.value, with: { snapshot in
            let isConnected = snapshot.value as? Bool ?? false
            
            if !isConnected {
                _wordsRef.removeAllObservers()
                completion(false)
            }
            
        })
    }
    
    private func mapIdsToRounds(rounds: [Round]) -> [Int: Round] {
        var roundMap = [Int : Round]()
        for round in rounds {
            roundMap[Int(round.id)] = round
        }
        
        return roundMap
    }
}
