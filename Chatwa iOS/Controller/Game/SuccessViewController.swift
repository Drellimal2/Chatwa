//
//  SuccessViewController.swift
//  Chatwa iOS
//
//  Created by QualityWorks on 7/7/17.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit
import AVFoundation

class SuccessViewController: UIViewController {
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!

    lazy var awohSoundPlayer: AVAudioPlayer? = self.getAwohSoundPlayer()
    
    var hint: String?
    var answer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let hint = hint {
            hintLabel.text = hint
        }
        
        if let answer = answer {
            answerLabel.text = answer
        }
    }
    
    @IBAction func awohButtonClicked(_ sender: Any) {
        playAudio(player: awohSoundPlayer)
        dismiss(animated: true, completion: nil)
    }
}
