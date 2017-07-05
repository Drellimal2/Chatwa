//
//  DataManager.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 12/06/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataManager {
    static var shared = DataManager()
    
    let api = API.shared
    
    func saveRoundsFromJSON(jsonResult: Any) {
        _ = JSON(jsonResult)
    }
    
    
    func getRounds() {
        Alamofire.request(api.rounds()).responseJSON { response in
            if let jsonResult = response.result.value {
                debugPrint("Round JSON: \(jsonResult)")
                self.saveRoundsFromJSON(jsonResult: jsonResult)
            }
        }
    }
}
