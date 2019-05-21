//
//  FinishGoalVC.swift
//  Dev-goalpost
//
//  Created by Mac User on 5/16/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate  {
    // Outlets
    @IBOutlet weak var pointsTextField: UITextField!
    // Vars
    var goalDescription: String!
    var goalType: GoalType!
    // Init
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pointsTextField.delegate = self
        let createGoalBtn = UserActionButton(title: "CREATE GOAL", action: #selector(createGoalBtnPressed), owner: self, backColor: #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1), btnTextColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        pointsTextField.inputAccessoryView = createGoalBtn
    }   // end view did load
    @objc func createGoalBtnPressed() {
        if pointsTextField.text != "" {
            self.save { (complete) in
                if complete {
                    goalWasSet = true
                    dismissToRoot()
                }   }   }   }
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        do {
        try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }   }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
}
