//
//  GameViewController+PurchaseUtils.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 7/10/17.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation
import UIKit

extension GameViewController {
    func showPattyPurchaseOption() {
        print("Options")
        if let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "PattyOptionsViewController") {
            let nav = UINavigationController(rootViewController: popoverContent)
            nav.modalPresentationStyle = .popover
            let popover = nav.popoverPresentationController
            popoverContent.preferredContentSize = CGSize(width: 500, height: 600)
            popover?.delegate = self
            popover?.sourceView = pattyCountLabel
            popover?.sourceRect = CGRect(x: 100, y: 100, width: 0, height: 0)
            
            self.present(nav, animated: true, completion: nil)
        }
        
    }
}

extension GameViewController: UIPopoverPresentationControllerDelegate{
    
}


