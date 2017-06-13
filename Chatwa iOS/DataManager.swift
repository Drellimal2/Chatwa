//
//  DataManager.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 12/06/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation
import Alamofire

class DataManager {
    static var shared = DataManager()
    
    let api = API.shared
    
    func saveRoundsFromJSON(json: Dictionary<String, Any>) {
        
    }
    
    
    func getRounds() {
        Alamofire.request(api.rounds()).responseJSON { response in
            if let JSON = response.result.value {
                debugPrint("Round JSON: \(JSON)")
                //
            }
        }
    }
}
