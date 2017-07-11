//
//  GameViewController+SocialSharing.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 7/8/17.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation
import UIKit

extension GameViewController {
    
    func generateShareImage() -> UIImage {
        showNavigationBar(show: false)
        let shareImage = renderViewToImage()
        showNavigationBar()
        return shareImage
    }
    
    func askForHelp() {
        let activityContoller = UIActivityViewController(activityItems: [generateShareImage()], applicationActivities: nil)
        self.present(activityContoller, animated: true, completion: nil)
        
        activityContoller.completionWithItemsHandler = {(activityType, completed, items, error) in
            if let error = error {
                print(error.localizedDescription)
                self.alert(message: "Could not present options for you to share your to friedns :(", title: "Error sharing")
            }
            
        }
    }
}
