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
        hintLabel.text = Constants.DummyData.hint
        answer = Constants.DummyData.answer
        
        let characters = answer.characters
        let numberOfCharacters = characters.count
        
        for _ in 0...(numberOfCharacters - 1) {
            let answerButton = AnswerButton()
            answerButton.addTarget(self, action: #selector(self.answerButtonClicked(_:)), for: .touchUpInside)
            answerButtons.append(answerButton)
            answerStackView.addArrangedSubview(answerButton)
        }
        
        let gridString = Constants.DummyData.grid
        
        for index in 0...(Constants.Values.lettersInRow - 1) {
            let row1Button = GridButton()
            let row2Button = GridButton()
            
            row1Button.addTarget(self, action: #selector(self.gridButtonClicked(_:)), for: .touchUpInside)
            row2Button.addTarget(self, action: #selector(self.gridButtonClicked(_:)), for: .touchUpInside)
            
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
        
    }
    
    
    func setupPattyBarButtonItem() {
        
        guard let navigationBarHeight = self.navigationBarHeight else {
            return
        }
        
        let pattyContainerView = UIView(frame: CGRect(x: 0, y: 0,width: 130, height: navigationBarHeight))
        pattyContainerView.backgroundColor = .pattiesBackground
        pattyContainerView.setDefaultCornerRadius()
        
        let pattyImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        pattyImageView.image = UIImage(named: "Patty Icon")
        pattyImageView.contentMode = .scaleAspectFill
        pattyContainerView.addSubview(pattyImageView)
        
        
        let pattyCountLabel = UILabel(frame: CGRect(x: 40, y: 0,width: 100, height: navigationBarHeight))
        pattyCountLabel.text = "9999 Patties"
        pattyCountLabel.font = UIFont(name: "Chalkboard SE", size: 14)
        pattyCountLabel.textColor = .pattiesLetterColor
        pattyCountLabel.textAlignment = .left
        pattyContainerView.addSubview(pattyCountLabel)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pattyContainerView)
    }
    
    func setupTitleImageView() {
        roundNumber = 0 // TODO: get actual round number
        
        guard let navigationBarHeight = self.navigationBarHeight else {
            return
        }
        
        let roundView = UIView()
        roundView.frame = CGRect(x: 0, y: 0, width: navigationBarHeight, height: navigationBarHeight)
        roundView.backgroundColor = .pattiesBackground
        roundView.setCornerRadius(radius: 20)
        
        let roundLabel = UILabel(frame: CGRect(x: 0, y: 0, width: navigationBarHeight, height: navigationBarHeight))
        roundLabel.text = "\(roundNumber!)"
        roundLabel.textAlignment = .center
        roundLabel.font = UIFont(name: "Chalkboard SE", size: 14)
        roundLabel.textColor = .roundNumberColor
        roundView.addSubview(roundLabel)
        
        self.navigationItem.titleView = roundView
    }
    
    func setupPronunciationButton() {
        pronunciationButton.isHidden = true
        pronunciationButton.isEnabled = false
    }
    
    // Adjusts the value of the constraint keeping the label in the center of the screenhorizontally
    // +/- width of the screen based on parameter truthness
    func setYaadieLabelVisibility(visible: Bool) {
        yaadieLabel.isHidden = !visible
        awohButton.isHidden = !visible
        let f: (NSLayoutConstraint)->Void = visible ? { $0.constant += self.view.bounds.width }: { $0.constant -= self.view.bounds.width }
        f(yaadieLabelConstraint)
    }
    
    // Adjusts the value of the constraint keeping the button in the center of the screen horizontally
    // +/- width of the screen based on parameter truthness
    func setAwohButtonVisibility(visible: Bool) {
        let f: (NSLayoutConstraint)->Void = visible ? { $0.constant += self.view.bounds.width }: { $0.constant -= self.view.bounds.width }
        f(awohButtonConstraint)
    }
    
    func setSuccessMessageVisibility(visible: Bool) {
        setYaadieLabelVisibility(visible: visible)
        setAwohButtonVisibility(visible: visible)
    }
    
    func setup() {
        showNavigationBar()
        navigationBarHeight = self.navigationController?.navigationBar.frame.height
        setupPattyBarButtonItem()
        setupTitleImageView()
        setupPronunciationButton()
        setSuccessMessageVisibility(visible: false)
    }
}
