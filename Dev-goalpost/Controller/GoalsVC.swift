//
//  ViewController.swift
//  Dev-goalpost
//
//  Created by Mac User on 5/16/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

let appDelegate = UIApplication.shared.delegate as? AppDelegate
var goalWasSet = false

class GoalsVC: UIViewController {
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    // Vars
    var player = AVAudioPlayer()
    var goals: [Goal] = []
    let deletePath = Bundle.main.path(forResource:"deleteGoal", ofType: "wav")
    let setPath = Bundle.main.path(forResource:"goalSet", ofType: "mp3")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }   // end viewDidLoad
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchCoreDataObjects()
        tableView.reloadData()
        if goalWasSet {
            do {
                try self.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: self.setPath!))
            } catch {
                print("set fail")
            }
            self.player.play()
            goalWasSet = false
        }
    }
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }   }   }
    }
    @IBAction func addGoalBtnPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        presentDetail(createGoalVC)
    }
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        let goal = goals[indexPath.row]
        cell.configureCell(description: goal.goalDescription!, type: GoalType(rawValue: goal.goalType!)!, goalProgress: goal.goalProgress, goalCompletion: goal.goalCompletionValue)
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            do {
                try self.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: self.deletePath!))
            } catch {
                print("delete fail")
            }
            self.player.play()
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        addAction.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
        return [deleteAction, addAction]
    }
}

extension GoalsVC {
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(goals[indexPath.row])
        do {
            try managedContext.save()
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
        }
    }
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        do {
            goals = try managedContext.fetch(fetchRequest) as! [Goal]
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {
            return
        }
        do {
            try managedContext.save()
        } catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
}
