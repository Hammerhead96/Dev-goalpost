//
//  CreateGoalVC.swift
//  Dev-goalpost
//
//  Created by Mac User on 5/16/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextFieldDelegate {
    // Outlets
    @IBOutlet weak var goalTextView: UITextField!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    // Vars
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTextView.delegate = self
//        let nextBtn = UserActionButton(title: "NEXT", action: #selector(nextBtnPressed), owner: self)
        let nextBtn = UserActionButton(title: "NEXT", action: #selector(nextBtnPressed), owner: self, backColor: #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1), btnTextColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        goalTextView.inputAccessoryView = nextBtn
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    } // end view did load
    @objc func nextBtnPressed() {
        if goalTextView.text != "" {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else { return }
            finishGoalVC.initData(description: goalTextView.text!, type: goalType)
            presentDetail(finishGoalVC)
        }
    }
    @IBAction func shortTermBtnPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    @IBAction func longTermBtnPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
}
