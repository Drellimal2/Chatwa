//
//  ViewController.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 25/05/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {

    lazy var clickSoundPlayer: AVAudioPlayer? = self.getClickSoundPlayer()
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigationBar(show: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.getRounds()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playButtonClicked(_ sender: Any) {
        play(player: clickSoundPlayer)
        self.performSegue(withIdentifier: SegueIdentifiers.game, sender: self)
    }

    @IBAction func instructionsButtonClicked(_ sender: Any) {
        play(player: clickSoundPlayer)
        self.present(buildInstructionsAlertContoller(), animated: true, completion: nil)
    }
    
    func buildInstructionsAlertContoller() -> UIAlertController{
        
        let alertController = UIAlertController(title: "", message:"", preferredStyle: .alert)
        alertController.view.tintColor = .letterColor // This changes the color of the defined action
        
        let dismissAction = UIAlertAction(title: StaticText.instructionsDismissText, style: .default, handler: nil)
//        let dismissAction = UIAlertAction(title: StaticText.instructionsDismissText, style: .default,handler: { alertAction in self.play(player: self.clickSoundPlayer) })
       
        alertController.addAction(dismissAction)
        
        
        alertController.setValue(textInChalboardSEFont(text: StaticText.instructionsTitle as NSString, color: .black, size: 24), forKey: "attributedTitle")
        alertController.setValue(textInChalboardSEFont(text: StaticText.instructionsMessage as NSString, color: .letterColor, size: 12), forKey: "attributedMessage")
        return alertController
    }
}

