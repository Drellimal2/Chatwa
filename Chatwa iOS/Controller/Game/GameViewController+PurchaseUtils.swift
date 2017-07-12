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
        if let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "PattyPurchaseOptionsViewController") as? PattyPurchaseOptionsViewController {
            let pattyPurchaseNavigationController = UINavigationController(rootViewController: popoverContent)
            pattyPurchaseNavigationController.modalPresentationStyle = .popover
            
            let purchasePopover = pattyPurchaseNavigationController.popoverPresentationController
            popoverContent.preferredContentSize = CGSize(width: 500, height: 320)
            purchasePopover?.delegate = self
            purchasePopover?.sourceView = pattyCountLabel
            
            self.present(pattyPurchaseNavigationController, animated: true, completion: nil)
        }
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension GameViewController: UIPopoverPresentationControllerDelegate{
    
}


