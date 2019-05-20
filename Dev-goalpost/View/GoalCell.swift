//
//  GoalCell.swift
//  Dev-goalpost
//
//  Created by Mac User on 5/16/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import UIKit
import AVFoundation

class GoalCell: UITableViewCell {
// Outlets
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    @IBOutlet weak var completionView: UIView!
    // Vars
    var goalCompletionValue: Int32!
    var player = AVAudioPlayer()
    let cheerPath = Bundle.main.path(forResource:"completed", ofType: "mp3")

    func configureCell(description: String, type: GoalType, goalProgress: Int32, goalCompletion: Int32) {
        self.goalDescriptionLbl.text = description
        self.goalTypeLbl.text = type.rawValue
        self.goalProgressLbl.text = String(describing: goalProgress)
        self.goalCompletionValue = goalCompletion
        if goalProgress == goalCompletion {
            do {
                try self.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: self.cheerPath!))
            } catch {
                print("cheer fail")
            }
            self.player.play()
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
    }
    
}
