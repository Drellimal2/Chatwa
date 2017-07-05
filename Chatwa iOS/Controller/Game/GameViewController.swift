//
//  GameViewController.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 31/05/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

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
    var answerGridMap = [AnswerButton: GridButton]()
    var answer: String!
    var roundNumber: Int!
    
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
    
    @IBAction func gridButtonClicked(_ sender: GridButton) {
        playClickSound()
        sender.isUserInteractionEnabled = false
        if hasEmptyAnswerSlot() {
            let letter = sender.titleLabel?.text
            if let emptySlot = firstEmptyAnswerSlot() {
                answerGridMap[emptySlot] = sender
                emptySlot.setTitle(letter, for: .normal)
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
        if let gridButton = answerGridMap[sender] {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that ca be recreated.
    }
}

extension GameViewController { // Functions primarily used to setup the Game UI Elements
    func loadAnswerAndGrid() {
        hintLabel.text = DummyData.hint
        answer = DummyData.answer
        
        if let firstButton = answerStackView.arrangedSubviews[0] as? AnswerButton {
            firstButton.setDefaultColor()
            answerButtons.append(firstButton)
            let characters = answer.characters
            let numberOfCharacters = characters.count
            
            let mainFont = firstButton.titleLabel?.font
            let mainFrame = firstButton.frame
            
            for _ in 1...(numberOfCharacters - 1) {
                let answerButton = AnswerButton(frame: mainFrame)
                answerButton.titleLabel?.font = mainFont
                answerButton.setDefaultColor()
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
            
            row1Button.setDefaultColor()
            row2Button.setDefaultColor()
            
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

extension GameViewController { // Functions used in Gameplay
    func playClickSound() {
        play(player: clickSoundPlayer)
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
    
    func firstEmptyAnswerSlot() -> AnswerButton? {
        for view in answerStackView.arrangedSubviews {
            if let answerButton = view as? AnswerButton {
                if answerButton.titleLabel?.text == nil {
                    return answerButton
                }
            }
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
        
        return proposedAnswer == answer
    }
    
    func wrongAnswer() {
        setAnswerColorRed()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))  // Vibrate device
    }
    
    func animateAppearance() {
        awohButton.isEnabled = false
        
        setYaadieLabelVisibility(visible: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
        setAwohButtonVisibility(visible: true)
        UIView.animate(withDuration: 0.5, delay: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion: { result in
            self.awohButton.isEnabled = true
        })
    }
    
    func animateDisappearance() {
        awohButton.isEnabled = false
        
        setAwohButtonVisibility(visible: false)
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
        setYaadieLabelVisibility(visible: false)
        UIView.animate(withDuration: 0.5, delay: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion: { result in
            self.setAllButtons(enabled: true)
        })
    }
    
    func correctAnswer() {
        setAllButtons(enabled: false)
        setCorrectTransitionViewVisibility(visible: true)
        animateAppearance()
    }
    
    func setCorrectTransitionViewVisibility(visible: Bool) {
        correctTransitionView.alpha = visible ? CGFloat(Values.correctTransitionViewAlpha): 0
    }
    
    func setAllButtons(enabled: Bool) {
        for view in answerStackView.arrangedSubviews {
            if let answerButton = view as? AnswerButton {
                answerButton.isEnabled = enabled
            }
        }
        
        let row1LetterButtons = row1StackView.arrangedSubviews
        let row2LetterButtons = row2StackView.arrangedSubviews
        
        for index in 0...(Values.lettersInRow - 1) {
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
