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

    lazy var awohSoundPlayer: AVAudioPlayer? = self.getAwohSoundPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func awohButtonClicked(_ sender: Any) {
        playAudio(player: awohSoundPlayer)
        dismiss(animated: true, completion: nil)
    }
}
