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
        let nextBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        nextBtn.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
        nextBtn.setTitle("NEXT", for: .normal)
        nextBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        nextBtn.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
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
