//
//  UIViewController+Utils.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 7/5/17.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension UIViewController {
    
    func alert(message: String, title: String = "", handler: ((UIAlertAction) -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showNavigationBar(show: Bool = true) {
        navigationController?.setNavigationBarHidden(!show, animated: true)
    }
    
    func textInChalboardSEFont(text: NSString, color: UIColor, size: Int) -> NSMutableAttributedString {
        let chalkboardSEFont = UIFont(name: "Chalkboard SE", size: CGFloat(size))!
        return textInFont(text: text, color: color, font: chalkboardSEFont)
    }
    
    func getClickSoundPlayer() -> AVAudioPlayer? {
        let click = Bundle.main.path(forResource: "click", ofType: "mp3")
        // copy this syntax, it tells the compiler what to do when action is received
        do {
            let clickSoundPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: click! ))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
            
            return clickSoundPlayer
        }
        catch{
            print(error)
        }
        return nil
    }
    
    func getAwohSoundPlayer() -> AVAudioPlayer? {
        let awoh = Bundle.main.path(forResource: "awoh", ofType: "mp3")
        // copy this syntax, it tells the compiler what to do when action is received
        do {
            let awohSoundPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: awoh! ))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
            
            return awohSoundPlayer
        }
        catch{
            print(error)
        }
        return nil
    }
    
    func playAudio(player: AVAudioPlayer?) {
        guard let player = player else {
            print("Audio Player is nil!")
            return
        }
        player.prepareToPlay()
        player.play()
        
    }
    
    func textInFont(text: NSString, color: UIColor, font: UIFont) -> NSMutableAttributedString {
        
        let systemBoldAttributes:[String : AnyObject] = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName : color
        ]
        
        return NSMutableAttributedString(string: text as String, attributes:systemBoldAttributes)
        
    }
    
    func renderViewToImage() -> UIImage {
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
}
