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
        self.performSegue(withIdentifier: "showSuccess", sender: self)
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
}
