//
//  GameViewController.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 31/05/2017.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var answerScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp() // Set up UI Elements and pre game cofiguration
    }
    
    func setUp() {
        setUpPattyBarButtonItem()
        setUpTitleImageView()
//        setUpAnswerScrollView()
    }
    
    func setUpAnswerScrollView() {
        let offsetX = max((answerScrollView.bounds.width - answerScrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((answerScrollView.bounds.height - answerScrollView.contentSize.height) * 0.5, 0)
        self.answerScrollView.contentInset = UIEdgeInsetsMake(offsetY, offsetX, 0, 0)
    }
    
    func setUpPattyBarButtonItem() {
        let containView = UIView(frame: CGRect(x: 0, y: 0,width: 130, height: 40))
        containView.backgroundColor = Colors.pattiesBackground
        containView.setDefaultCornerRadius()
        
        let pattyImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        pattyImageView.image = UIImage(named: "Patty Icon")
        pattyImageView.contentMode = .scaleAspectFill
        containView.addSubview(pattyImageView)
        
        
        let pattyCountLabel = UILabel(frame: CGRect(x: 40, y: 0,width: 100, height: 40))
        pattyCountLabel.text = "9999 Patties"
        pattyCountLabel.font = UIFont(name: "Chalkboard SE", size: 14)
        pattyCountLabel.textColor = Colors.pattiesLetterColor
        pattyCountLabel.textAlignment = .left
        containView.addSubview(pattyCountLabel)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: containView)
    }
    
    func setUpTitleImageView() {
        let roundView = UIView()
        roundView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        roundView.backgroundColor = Colors.pattiesBackground
        roundView.setCornerRadius(radius: 20)
        
        let roundLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        roundLabel.text = "999"
        roundLabel.textAlignment = .center
        roundLabel.font = UIFont(name: "Chalkboard SE", size: 14)
        roundLabel.textColor = Colors.roundNumberColor
        roundView.addSubview(roundLabel)
        
        self.navigationItem.titleView = roundView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
