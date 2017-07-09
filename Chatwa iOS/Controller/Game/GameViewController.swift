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

class GameViewController: UIViewController { // Outlets and overriden functions
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var answerStackView: UIStackView!
    @IBOutlet weak var row1StackView: UIStackView!
    @IBOutlet weak var row2StackView: UIStackView!
    
    var roundLabel: UILabel?
    var pattyCountLabel: UILabel?
    
    lazy var clickSoundPlayer: AVAudioPlayer? = self.getClickSoundPlayer()
    
    var navigationBarHeight: CGFloat?
    var answerButtons = [AnswerButton]()
    var gridButtons = [GridButton]()
    var answerGridMap = AnswerIndexToGridIndexMap()
    var round: Round?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context: NSManagedObjectContext = self.appDelegate.coreDataStack.context // MOC
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("View Setup")
        setup() // Set up UI Elements
        fetchRound() // Get the Current Round
        
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if(self.isMovingFromParentViewController) { // Play sound when back button is clicked
            playAudio(player: self.clickSoundPlayer)
        }
    }
    
    func fetchRound() {
        let fetchRequest: NSFetchRequest<Round> = Round.fetchRequest()
        print(getRoundNumber())
        let predicate = NSPredicate(format: "id = %@", argumentArray: [getRoundNumber()])
        fetchRequest.predicate = predicate
        
        do {
            let rounds = try context.fetch(fetchRequest)
            
            if rounds.count != 1 {
                alert(message: "There are no preloaded rounds right now, Check back later for more levels.", title: "Oh No!", handler: { action in
                    self.navigationController?.popViewController(animated: true)
                })
            } else {
                round = rounds[0]
                loadAnswerAndGrid()
            }
        } catch {
            print(error.localizedDescription)
            alert(message: "There was an error getting the information for the level. Please try again later.", title: "Oh No!", handler: { action in
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
    
    func gridIndexInAnswerMap(gridIndex: Int) -> AnswerButton? {
        
        for (answerIndex, _gridIndex) in answerGridMap {
            if _gridIndex == gridIndex {
                return answerButtons[answerIndex]
            }
        }
        return nil
    }
    
    // MARK:- IBActions
    
    @IBAction func helpButtonClicked(_ sender: Any) {
        showHelpAlert(handler: { shouldBuyLetter in
            if shouldBuyLetter {
                self.buyLetter()
            }
        })
    }
    
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
            
            checkAnswer()
            
        }
        
        sender.isUserInteractionEnabled = true
        
    }
    
    @IBAction func answerButtonClicked(_ sender: AnswerButton) {
        guard sender.isEnabled else {
            return
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSuccess" {
            let vc = segue.destination as! SuccessViewController
            vc.hint = round?.hint
            vc.answer = round?.answer
        }
    }
}


