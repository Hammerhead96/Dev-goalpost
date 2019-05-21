//
//  AudioManager.swift
//  Dev-goalpost
//
//  Created by Mac User on 5/21/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import Foundation
import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    private init(){}
    var player = AVAudioPlayer()
    func playSound (name: String, type: String) {
        let soundPath = Bundle.main.path(forResource: name, ofType: type)
        do {
            try self.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath!))
        } catch {
            print("Audio Manager Failed")
        }
        self.player.play()
    }
}

