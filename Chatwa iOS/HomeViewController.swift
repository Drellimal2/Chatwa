//
//  ViewController.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 25/05/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        showNavigationBar(show: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: SegueIdentifiers.game, sender: self)
    }

    @IBAction func instructionsButtonClicked(_ sender: Any) {
        self.present(buildInstructionsAlertContoller(), animated: true, completion: nil)
    }
    
    func buildInstructionsAlertContoller() -> UIAlertController{
        
        let alertController = UIAlertController(title: "", message:"", preferredStyle: .alert)
        alertController.view.tintColor = Colors.letterColor // This changes the color of the defined action
        
        let dismissAction = UIAlertAction(title: StaticText.instructionsDismissText, style: .default,handler: nil)
       
        alertController.addAction(dismissAction)
        
        
        alertController.setValue(textInChalboardSEFont(text: StaticText.instructionsTitle as NSString, color: .black, size: 24), forKey: "attributedTitle")
        alertController.setValue(textInChalboardSEFont(text: StaticText.instructionsMessage as NSString, color: Colors.letterColor, size: 12), forKey: "attributedMessage")
        return alertController
    }
    
    func textInChalboardSEFont(text: NSString, color: UIColor, size: Int) -> NSMutableAttributedString {
        let chalkboardSEFont = UIFont(name: "Chalkboard SE", size: CGFloat(size))!
        return textInFont(text: text, color: color, font: chalkboardSEFont)
    }
    
    func textInFont(text: NSString, color: UIColor, font: UIFont) -> NSMutableAttributedString {
        
        let systemBoldAttributes:[String : AnyObject] = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName : color
        ]
        
        return NSMutableAttributedString(string: text as String, attributes:systemBoldAttributes)
        
    }
}

