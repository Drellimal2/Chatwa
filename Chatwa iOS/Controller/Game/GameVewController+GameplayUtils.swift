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
    
    func hasEnoughPatties() -> Bool {
        let pattyCount = UserDefaults.standard.integer(forKey: "patties")
        
        return pattyCount >= Constants.Costs.letterCost
    }
    
    func increasePattyCount(by increment: Int) {
        UserDefaults.standard.set(pattyCount() + increment, forKey: "patties")
        refreshPattyCountLabel()
        pattyStepper.value = Double(pattyCount())
    }
    
    func nextRound() {
        UserDefaults.standard.set(getRoundNumber() + 1, forKey: "round")
        let data = NSKeyedArchiver.archivedData(withRootObject:GridToAnswerIndexMap()) //archiving
        
        UserDefaults.standard.set(data, forKey: "purchasedLetters") // The letters the user has purchased, upperbound length of Constants.Values.maxLettersInAnswer
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
        gridButtons = [GridButton]()
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
        
        let gridAnswerIndexData = UserDefaults.standard.object(forKey: "purchasedLetters") as! Data  //reading
        let gridAnswerIndexMap = NSKeyedUnarchiver.unarchiveObject(with: gridAnswerIndexData) as! GridToAnswerIndexMap //unarchiving
        
        var randomIndices = answer?.characters.enumerated().map({ $0.offset })
        
        for (_, answerIndex) in gridAnswerIndexMap {
            randomIndices = randomIndices?.filter({ $0 != answerIndex } )
        }
        
        var randomIndex = Int(arc4random_uniform(UInt32((randomIndices?.count)!)))
        let randomAnswerIndex = randomIndices?[randomIndex]
        
        var randomGridButtons = [Int]()
        
        let startIndex = answer?.startIndex
        let answerLetter = String(describing: answer![(answer?.index(startIndex!, offsetBy: randomAnswerIndex!))!])
        
        for gridButton in gridButtons {
            let letter = (gridButton.titleLabel?.text)!
    
            if gridButton.isEnabled,letter == answerLetter { // If the gridbutton is not used in a purchase already and the letter matches the answer letter
                randomGridButtons.append(gridButtons.index(of: gridButton)!)
            }
        }
        
        randomIndex = Int(arc4random_uniform(UInt32(randomGridButtons.count)))
        let randomGridIndex = randomGridButtons[randomIndex]
        
        return (gridIndex: randomGridIndex, answerIndex: randomAnswerIndex!)
    }
    
    func buyLetter() {
        
        guard hasEnoughPatties() else {
            print("Not enough patties to buy letter")
            alert(message: "You don't have enough patties, Click the Patty icon in the top right to buy some more.", title: "Oh No!", handler: nil)
            return
        }
        
        increasePattyCount(by: -Constants.Costs.letterCost)
        let positions = pickRandomLetterIndex()
        
        let gridIndex = positions.gridIndex
        let answerIndex = positions.answerIndex
        
        // Save the purchsed postions
        
        let gridAnswerIndexData = UserDefaults.standard.object(forKey: "purchasedLetters") as! Data  //reading
        var gridAnswerIndexMap = NSKeyedUnarchiver.unarchiveObject(with: gridAnswerIndexData) as! GridToAnswerIndexMap //unarchiving
        gridAnswerIndexMap[gridIndex] = answerIndex
        
        let data = NSKeyedArchiver.archivedData(withRootObject: gridAnswerIndexMap) //archiving
        
        UserDefaults.standard.set(data, forKey: "purchasedLetters")
        
        // Find the two buttons to be used
        
        let gridButton = gridButtons[gridIndex]
        let answerButton = answerButtons[answerIndex]
        
        // Check if either the answer or gridbuttons are used already and restore to default positions
        
        if let existingGridIndex = answerGridMap[answerIndex] { // A grid button exists in the chosen position, remove it
            let _gridButton = gridButtons[existingGridIndex]
            setAnswerColorDefault()
            answerButton.setTitle(nil, for: .normal)
            answerButton.titleLabel?.text = nil
            show(button: _gridButton)
        }
        
        if let _answerButton = gridIndexInAnswerMap(gridIndex: gridIndex) { // An aswer button is already using our grid button
            setAnswerColorDefault()
            _answerButton.setTitle(nil, for: .normal)
            _answerButton.titleLabel?.text = nil
            show(button: gridButton)
        }
        
        // Give user the letter and disable the answerButton
        let letter = gridButton.titleLabel?.text
        answerGridMap[answerIndex] = gridIndex
        
        answerButton.setTitle(letter, for: .normal)
        answerButton.disable()
        answerButton.backgroundColor = .blue
        gridButton.disable()
        hide(button: gridButton)
        
        checkAnswer()
    }
}
