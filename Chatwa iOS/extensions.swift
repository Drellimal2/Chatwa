//
//  extensions.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 31/05/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showNavigationBar(show: Bool = true) {
        self.navigationController?.setNavigationBarHidden(!show, animated: true)
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
    
    func play(player: AVAudioPlayer?) {
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
}


extension UIColor {
    
    static let letterColor = UIColor(hexValue: 0x40B320)
    static let letterBackground = UIColor(hexValue: 0xAAC9A2)
    static let pattiesBackground = UIColor(hexValue: 0x397D02)
    static let pattiesLetterColor = UIColor.white
    static let roundNumberColor = UIColor.white
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hexValue:Int) {
        self.init(red:(hexValue >> 16) & 0xff, green:(hexValue >> 8) & 0xff, blue:hexValue & 0xff)
    }
    
}

extension UIView {
    func setCornerRadius(radius: Int) {
        self.layer.cornerRadius = CGFloat(radius)
    }
    
    func setDefaultCornerRadius() {
        self.layer.cornerRadius = CGFloat(Values.defaultRadius)
    }

}
