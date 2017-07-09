//
//  GameVewController+GameplayUtils.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 7/5/17.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension GameViewController { // Functions used in Gameplay
    func playClickSound() {
        playAudio(player: clickSoundPlayer)
    }
    
    func hide(button: UIButton) {
        button.alpha = 0
        button.isUserInteractionEnabled = false
    }
    
    func show(button: UIButton) {
        button.alpha = 1
        button.isUserInteractionEnabled = true
    }
    
    func hasEmptyAnswerSlot() -> Bool {
        for view in answerStackView.arrangedSubviews {
            if let answerButton = view as? AnswerButton {
                if answerButton.titleLabel?.text == nil {
                    return true
                }
            }
        }
        return false
    }
    
    func firstEmptyAnswerSlot() -> Int? {
        var index = 0
        for view in answerStackView.arrangedSubviews {
            if let answerButton = view as? AnswerButton {
                if answerButton.titleLabel?.text == nil {
                    return index
                }
            }
            index += 1
        }
        return nil
    }
    
    func setAnswerColorRed() {
        for view in answerStackView.arrangedSubviews {
            if let answerButton = view as? AnswerButton {
                answerButton.setWrongAnswerColor()
                answerButton.setNeedsDisplay()
            }
        }
    }
    
    func setAnswerColorDefault() {
        for view in answerStackView.arrangedSubviews {
            if let answerButton = view as? AnswerButton {
                answerButton.setDefaultColor()
            }
        }
    }
    
    func isCorrectAnswer() -> Bool {
        var proposedAnswer = ""
        for view in answerStackView.arrangedSubviews {
            if let answerButton = view as? AnswerButton {
                proposedAnswer += (answerButton.titleLabel?.text)!
            }
        }
        
        return proposedAnswer == round?.answer
    }
    
    func wrongAnswer() {
        setAnswerColorRed()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))  // Vibrate device
    }
    
    func increasePattyCount(by increment: Int) {
        UserDefaults.standard.set(pattyCount() + increment, forKey: "patties")
    }
    
    func nextRound() {
        UserDefaults.standard.set(getRoundNumber() + 1, forKey: "round")
        UserDefaults.standard.set(GridToAnswerIndexMap(), forKey: "purchasedLetters") // The letters the user has purchased, upperbound length of Constants.Values.maxLettersInAnswer
    }
    
    func refreshPattyCountLabel() {
        pattyCountLabel?.text = "\(pattyCount())"
    }
    
    func pattyCount() -> Int {
        return UserDefaults.standard.integer(forKey: "patties")
    }
    
    func getRoundNumber() -> Int {
        return UserDefaults.standard.integer(forKey: "round")
    }
    
    
    func correctAnswer() {
        setAllButtons(enabled: false)
        increasePattyCount(by: 1)
        nextRound()
        tearDown()
        self.performSegue(withIdentifier: "showSuccess", sender: self)
    }
    
    func tearDown() {
        answerButtons = [AnswerButton]()
        answerStackView.clear()
        row1StackView.clear()
        row2StackView.clear()
    }
    
    func setAllButtons(enabled: Bool) {
        for view in answerStackView.arrangedSubviews {
            if let answerButton = view as? AnswerButton {
                answerButton.isEnabled = enabled
            }
        }
        
        let row1LetterButtons = row1StackView.arrangedSubviews
        let row2LetterButtons = row2StackView.arrangedSubviews
        
        for index in 0...(Constants.Values.lettersInRow - 1) {
            guard let row1Button = row1LetterButtons[index] as? GridButton else {
                continue
            }
            
            guard let row2Button = row2LetterButtons[index] as? GridButton else {
                continue
            }
            
            row1Button.isEnabled = enabled
            row2Button.isEnabled = enabled
        }
    }
    
    func showHelpAlert(handler: @escaping (Bool) -> ()) { // Handler parameter is true if the users wants the letter, false otherwise
        let alertController = UIAlertController(title: "Need help?", message: "Use \(Constants.Costs.letterCost) patties to get a letter in the answer?", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Ye Mon!", style: .default, handler: { action in
            handler(true)
        })
        let cancelAction = UIAlertAction(title: "No sah!", style: .default, handler: { action in
            handler(false)
        })
        
        alertController.addAction(OKAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkAnswer() {
        if !hasEmptyAnswerSlot() {
            if isCorrectAnswer() {
                correctAnswer()
            } else {
                wrongAnswer()
            }
        }
    }
    
    func pickRandomLetterIndex() -> GridToAnswerIndex { // Return the index position in the grid of a random letter in the answer and the associated answerIndex

        let answer = round?.answer
        
        let gridAnswerIndexMap = UserDefaults.standard.object(forKey: "purchasedLetters") as! GridToAnswerIndexMap
        
        var randomIndices = answer?.characters.enumerated().map({ $0.offset })
        
        for (_, answerIndex) in gridAnswerIndexMap {
            randomIndices = randomIndices?.filter({ $0 == answerIndex } )
        }
        
        var randomIndex = Int(arc4random_uniform(UInt32((randomIndices?.count)!)))
        let randomAnswerIndex = randomIndices?[randomIndex]
        
        var randomGridButtons = [Int]()
        
        for gridButton in gridButtons {
            let letter = (gridButton.titleLabel?.text)!
            
            let startIndex = answer?.startIndex
            let answerLetter = String(describing: answer?.index(startIndex!, offsetBy: randomAnswerIndex!))
            if gridButton.isEnabled,letter == answerLetter { // If the gridbutton is not used in a purchase already and the letter matches the answer letter
                randomGridButtons.append(gridButtons.index(of: gridButton)!)
            }
        }
        
        randomIndex = Int(arc4random_uniform(UInt32(randomGridButtons.count)))
        let randomGridIndex = randomGridButtons[randomIndex]
        
        return (gridIndex: randomGridIndex, answerIndex: randomAnswerIndex!)
    }
}
