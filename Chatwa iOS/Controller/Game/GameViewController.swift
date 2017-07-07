//
//  GameViewController.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 31/05/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import AudioToolbox

typealias AnswerIndexToGridIndexMap = [Int: Int]

class GameViewController: UIViewController { // Outlets and overriden functions
    @IBOutlet weak var correctTransitionView: UIView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var pronunciationButton: UIButton!
    @IBOutlet weak var answerStackView: UIStackView!
    @IBOutlet weak var row1StackView: UIStackView!
    @IBOutlet weak var row2StackView: UIStackView!
    @IBOutlet weak var yaadieLabel: UILabel!
    @IBOutlet weak var awohButton: UIButton!
    @IBOutlet weak var yaadieLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var awohButtonConstraint: NSLayoutConstraint!
    
    lazy var clickSoundPlayer: AVAudioPlayer? = self.getClickSoundPlayer()
    lazy var awohSoundPlayer: AVAudioPlayer? = self.getAwohSoundPlayer()
    
    var navigationBarHeight: CGFloat?
    var answerButtons = [AnswerButton]()
    var gridButtons = [GridButton]()
    var answerGridMap = AnswerIndexToGridIndexMap()
    var answer: String!
    var roundNumber: Int!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context: NSManagedObjectContext = self.appDelegate.coreDataStack.context // MOC
    
    // MARK:- Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        print("View Setup")
        setup() // Set up UI Elements and pre game cofiguration
        loadAnswerAndGrid()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if(self.isMovingFromParentViewController) { // Play sound when back button is clicked
            play(player: self.clickSoundPlayer)
        }
    }
    
    func fetchRounds() {
        let fetchRequest: NSFetchRequest<Round> = Round.fetchRequest()
        
        do {
            let rounds = try context.fetch(fetchRequest)
            
            print("Round count: \(rounds.count)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK:- IBActions
    
    @IBAction func gridButtonClicked(_ sender: GridButton) {
        playClickSound()
        sender.isUserInteractionEnabled = false
        if hasEmptyAnswerSlot() {
            let letter = sender.titleLabel?.text
            if let emptySlot = firstEmptyAnswerSlot() {
                let gridIndex = gridButtons.index(of: sender)
                answerGridMap[emptySlot] = gridIndex
                
                let answerButton = answerStackView.arrangedSubviews[emptySlot] as! AnswerButton
                answerButton.setTitle(letter, for: .normal)
                hide(button: sender)
            }
            
            if !hasEmptyAnswerSlot() {
                if isCorrectAnswer() {
                    correctAnswer()
                } else {
                    wrongAnswer()
                }
            }
            
        }
        
        sender.isUserInteractionEnabled = true
        
    }
    
    @IBAction func answerButtonClicked(_ sender: AnswerButton) {
        sender.isUserInteractionEnabled = false
        let answerIndex = answerStackView.arrangedSubviews.index(of: sender)
        if let gridIndex = answerGridMap[answerIndex!] {
            let gridButton = gridButtons[gridIndex]
            playClickSound()
            setAnswerColorDefault()
            sender.setTitle(nil, for: .normal)
            sender.titleLabel?.text = nil
            show(button: gridButton)
        }
        
        sender.isUserInteractionEnabled = true
        
    }
    
    @IBAction func pronunciationButtonClicked(_ sender: Any) {
    }
    
    @IBAction func awohButtonClicked(_ sender: Any) {
        play(player: awohSoundPlayer)
    }
}


