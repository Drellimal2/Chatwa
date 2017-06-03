//
//  GameViewController.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 31/05/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var answerStackView: UIStackView!
    @IBOutlet weak var row1StackView: UIStackView!
    @IBOutlet weak var row2StackView: UIStackView!
    
    var navigationBarHeight: CGFloat?
    
    override func viewWillAppear(_ animated: Bool) {
        loadDummyData()
        
    }
    
    override func viewDidLayoutSubviews() {
        print("View Setup")
        setUp() // Set up UI Elements and pre game cofiguration
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUp() {
        showNavigationBar()
        navigationBarHeight = self.navigationController?.navigationBar.frame.height
        setUpPattyBarButtonItem()
        setUpTitleImageView()
    }
    
    @IBAction func gridButtonClicked(_ sender: Any) {
    }
    
    func loadDummyData() {
        hintLabel.text = DummyData.hint
        let answer = DummyData.answer
        
        if let firstButton = answerStackView.arrangedSubviews[0] as? AnswerButton {
            let characters = answer.characters
            let numberOfCharacters = characters.count
            
            firstButton.setTitle(String(answer[answer.startIndex]), for: .normal)
            let mainFont = firstButton.titleLabel?.font
            let mainFrame = firstButton.frame
            
            for index in 1...(numberOfCharacters - 1) {
                let letterIndex = answer.index(answer.startIndex, offsetBy: index)
                let letter = answer[letterIndex]
                let answerButton = AnswerButton(frame: mainFrame)
                answerButton.titleLabel?.font = mainFont
                answerButton.setTitle(String(letter), for: .normal)
                answerStackView.addArrangedSubview(answerButton)
            }
        }
        
        let gridString = DummyData.grid
        
        let row1LetterButtons = row1StackView.arrangedSubviews
        let row2LetterButtons = row2StackView.arrangedSubviews
        
        for index in 0...(Values.lettersInRow - 1) {
            guard let row1Button = row1LetterButtons[index] as? GridButton else {
                continue
            }
            
            guard let row2Button = row2LetterButtons[index] as? GridButton else {
                continue
            }
            
            let row1LetterIndex = gridString.index(gridString.startIndex, offsetBy: index)
            let row2LetterIndex = gridString.index(gridString.startIndex, offsetBy: index + Values.lettersInRow)
            
            let row1Letter = gridString[row1LetterIndex]
            let row2Letter = gridString[row2LetterIndex]
            
            row1Button.setTitle(String(row1Letter), for: .normal)
            row2Button.setTitle(String(row2Letter), for: .normal)
        }
        
    }
    
    
    func setUpPattyBarButtonItem() {
        
        guard let navigationBarHeight = self.navigationBarHeight else {
            return
        }
        
        let containView = UIView(frame: CGRect(x: 0, y: 0,width: 130, height: navigationBarHeight))
        containView.backgroundColor = .pattiesBackground
        containView.setDefaultCornerRadius()
        
        let pattyImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        pattyImageView.image = UIImage(named: "Patty Icon")
        pattyImageView.contentMode = .scaleAspectFill
        containView.addSubview(pattyImageView)
        
        
        let pattyCountLabel = UILabel(frame: CGRect(x: 40, y: 0,width: 100, height: navigationBarHeight))
        pattyCountLabel.text = "9999 Patties"
        pattyCountLabel.font = UIFont(name: "Chalkboard SE", size: 14)
        pattyCountLabel.textColor = .pattiesLetterColor
        pattyCountLabel.textAlignment = .left
        containView.addSubview(pattyCountLabel)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: containView)
    }
    
    func setUpTitleImageView() {
        
        guard let navigationBarHeight = self.navigationBarHeight else {
            return
        }
        
        let roundView = UIView()
        roundView.frame = CGRect(x: 0, y: 0, width: navigationBarHeight, height: navigationBarHeight)
        roundView.backgroundColor = .pattiesBackground
        roundView.setCornerRadius(radius: 20)
        
        let roundLabel = UILabel(frame: CGRect(x: 0, y: 0, width: navigationBarHeight, height: navigationBarHeight))
        roundLabel.text = "999"
        roundLabel.textAlignment = .center
        roundLabel.font = UIFont(name: "Chalkboard SE", size: 14)
        roundLabel.textColor = .roundNumberColor
        roundView.addSubview(roundLabel)
        
        self.navigationItem.titleView = roundView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
