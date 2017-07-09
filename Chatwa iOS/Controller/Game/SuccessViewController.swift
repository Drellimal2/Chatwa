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
    @IBOutlet weak var navigationBar: UINavigationBar!
    
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
    
    func generateShareImage() -> UIImage {
        navigationBar.isHidden = true
        let shareImage = renderViewToImage()
        navigationBar.isHidden = false
        return shareImage
    }
    
    @IBAction func shareSuccess(_ sender: Any) {
        let activityContoller = UIActivityViewController(activityItems: [generateShareImage()], applicationActivities: nil)
        self.present(activityContoller, animated: true, completion: nil)
        
        activityContoller.completionWithItemsHandler = {(activityType, completed, items, error) in
            
            if let error = error {
                print(error.localizedDescription)
                self.alert(message: "Could not present options for you to share your success :(", title: "Error sharing")
            }
            
        }
    }
    
    @IBAction func awohButtonClicked(_ sender: Any) {
        playAudio(player: awohSoundPlayer)
        dismiss(animated: true, completion: nil)
    }
}
