//
//  FinishGoalVC.swift
//  Dev-goalpost
//
//  Created by Mac User on 5/16/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate  {
    // Outlets
    @IBOutlet weak var pointsTextField: UITextField!
    var goalDescription: String!
    var goalType: GoalType!
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pointsTextField.delegate = self
        let createGoalBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        createGoalBtn.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
        createGoalBtn.setTitle("NEXT", for: .normal)
        createGoalBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        createGoalBtn.addTarget(self, action: #selector(FinishGoalVC.createGoalBtnPressed), for: .touchUpInside)
        pointsTextField.inputAccessoryView = createGoalBtn
        
    }
    @objc func createGoalBtnPressed() {
        print("Booyah! Create!")
    }

    

}
