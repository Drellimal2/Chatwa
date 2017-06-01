//
//  ViewController.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 25/05/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: SegueIdentifiers.game, sender: self)
    }

    @IBAction func instructionsButtonClicked(_ sender: Any) {
    }
    
}

