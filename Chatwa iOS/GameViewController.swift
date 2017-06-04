//
//  GameViewController.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 31/05/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var answerStackView: UIStackView!
    @IBOutlet weak var row1StackView: UIStackView!
    @IBOutlet weak var row2StackView: UIStackView!
    
    lazy var clickSoundPlayer: AVAudioPlayer? = self.getClickSoundPlayer()
    
    var navigationBarHeight: CGFloat?
    var answerButtons = [AnswerButton]()
    
    override func viewWillAppear(_ animated: Bool) {
        loadAnswerAndGrid()
        
    }
    
    override func viewDidLayoutSubviews() {
        print("View Setup")
        setup() // Set up UI Elements and pre game cofiguration
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadAnswerAndGrid() {
        hintLabel.text = DummyData.hint
        let answer = DummyData.answer
        
        if let firstButton = answerStackView.arrangedSubviews[0] as? AnswerButton {
            answerButtons.append(firstButton)
            let characters = answer.characters
            let numberOfCharacters = characters.count
            
            let mainFont = firstButton.titleLabel?.font
            let mainFrame = firstButton.frame
            
            for _ in 1...(numberOfCharacters - 1) {
                let answerButton = AnswerButton(frame: mainFrame)
                answerButton.titleLabel?.font = mainFont
                answerButton.isUserInteractionEnabled = true
                answerButton.addTarget(self, action: #selector(self.answerButtonClicked(_:)), for: .touchUpInside)
                answerButtons.append(answerButton)
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
    
    
    func setupPattyBarButtonItem() {
        
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
    
    func setupTitleImageView() {
        
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
    
    func setup() {
        showNavigationBar()
        navigationBarHeight = self.navigationController?.navigationBar.frame.height
        setupPattyBarButtonItem()
        setupTitleImageView()
    }
    
    func playClickSound() {
        play(player: clickSoundPlayer)
    }
    
    func hide(button: UIButton) {
        button.alpha = 0
        button.isUserInteractionEnabled = false
    }
    
    @IBAction func gridButtonClicked(_ sender: GridButton) {
        playClickSound()
        hide(button: sender)
    }
    
    
    @IBAction func answerButtonClicked(_ sender: AnswerButton) {
        playClickSound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
