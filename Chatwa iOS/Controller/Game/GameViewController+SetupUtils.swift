//
//  GameViewController+SetupUtils.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 7/5/17.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import Foundation
import UIKit

extension GameViewController { // Functions primarily used to setup the Game UI Elements
    
    func loadAnswerAndGrid() { // Initial load of answer and bottom grid
        hintLabel.text = round!.hint
        
        let characters = round!.answer!.characters
        let numberOfCharacters = characters.count
        
        // Load the answer buttons
        
        for _ in 0...(numberOfCharacters - 1) {
            let answerButton = AnswerButton()
            answerButton.addTarget(self, action: #selector(answerButtonClicked(_:)), for: .touchUpInside)
            answerButtons.append(answerButton)
            answerStackView.addArrangedSubview(answerButton)
        }
        
        let gridString = round!.grid!
        
        // Load the grid buttons
        
        for index in 0...(Constants.Values.lettersInRow - 1) {
            let row1Button = GridButton()
            let row2Button = GridButton()
            
            row1Button.addTarget(self, action: #selector(gridButtonClicked(_:)), for: .touchUpInside)
            row2Button.addTarget(self, action: #selector(gridButtonClicked(_:)), for: .touchUpInside)
            
            let row1LetterIndex = gridString.index(gridString.startIndex, offsetBy: index)
            let row2LetterIndex = gridString.index(gridString.startIndex, offsetBy: index + Constants.Values.lettersInRow)
            
            let row1Letter = gridString[row1LetterIndex]
            let row2Letter = gridString[row2LetterIndex]
            
            row1Button.setTitle(String(row1Letter), for: .normal)
            row2Button.setTitle(String(row2Letter), for: .normal)
            
            row1StackView.addArrangedSubview(row1Button)
            row2StackView.addArrangedSubview(row2Button)
            
            gridButtons.append(row1Button)
            gridButtons.append(row2Button)
        }
        
        
        // check for purchased letters
        if let gridAnswerIndexData = UserDefaults.standard.object(forKey: "purchasedLetters") as? Data { //reading
            let gridAnswerIndexMap = NSKeyedUnarchiver.unarchiveObject(with: gridAnswerIndexData) as! GridToAnswerIndexMap //unarchiving
            for (gridIndex, answerIndex) in gridAnswerIndexMap {
                let gridButton = gridButtons[gridIndex]
                let answerButton = answerButtons[answerIndex]
                
                let letter = gridButton.titleLabel?.text
                answerGridMap[answerIndex] = gridIndex
                
                answerButton.setTitle(letter, for: .normal)
                answerButton.disable()
                gridButton.disable()
                hide(button: gridButton)
            }
        }
    }
    
    func setupNavigationBar() {
        showNavigationBar()
        navigationBarHeight = navigationController?.navigationBar.frame.height
        guard let pattyButtonItem = getPattyBarButtonItem(), let shareButtonItem = getSocialShareButton() else {
            return
        }
        pattyButtonItem.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(donatePatties)))
        navigationItem.rightBarButtonItems = [shareButtonItem, pattyButtonItem]
    }
    
    func getSocialShareButton() -> UIBarButtonItem? {
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(askForHelp))
        return shareButton
    }
    
    func getPattyBarButtonItem() -> UIBarButtonItem? {
        
        guard let navigationBarHeight = navigationBarHeight else {
            return nil
        }
        
        let pattyContainerView = UIView(frame: CGRect(x: 0, y: 0,width: navigationBarHeight + 50 + 10, height: navigationBarHeight))
        pattyContainerView.backgroundColor = .pattiesBackground
        pattyContainerView.setDefaultCornerRadius()
        
        let pattyImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: navigationBarHeight, height: navigationBarHeight))
        pattyImageView.image = UIImage(named: "Patty Icon")
        pattyImageView.contentMode = .scaleAspectFit
        pattyContainerView.addSubview(pattyImageView)
        
        
        pattyCountLabel = UILabel(frame: CGRect(x: navigationBarHeight + 10, y: 0,width: 50, height: navigationBarHeight))
        pattyCountLabel?.text = "\(pattyCount())"
        pattyCountLabel?.font = UIFont(name: "Chalkboard SE", size: 18)
        pattyCountLabel?.textColor = .pattiesLetterColor
        pattyCountLabel?.textAlignment = .left
        pattyContainerView.addSubview(pattyCountLabel!)
        
        return UIBarButtonItem(customView: pattyContainerView)
    }
    
    func setupTitleImageView() {
        
        guard let navigationBarHeight = navigationBarHeight else {
            return
        }
        
        let roundView = UIView()
        roundView.frame = CGRect(x: 0, y: 0, width: navigationBarHeight, height: navigationBarHeight)
        roundView.backgroundColor = .pattiesBackground
        roundView.setCornerRadius(radius: 20)
        
        roundLabel = UILabel(frame: CGRect(x: 0, y: 0, width: navigationBarHeight, height: navigationBarHeight))
        roundLabel?.text = "\(getRoundNumber() + 1)"
        roundLabel?.textAlignment = .center
        roundLabel?.font = UIFont(name: "Chalkboard SE", size: 14)
        roundLabel?.textColor = .roundNumberColor
        roundView.addSubview(roundLabel!)
        
        self.navigationItem.titleView = roundView
    }
    
    func setup() {
        setupNavigationBar()
        setupTitleImageView()
    }
}
