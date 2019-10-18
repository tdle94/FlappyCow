//
//  HighScore.swift
//  FlutterCow
//
//  Created by Tuyen Le on 10/18/19.
//  Copyright © 2019 Tuyen Le. All rights reserved.
//

import Foundation
import SpriteKit

class HighScoreLabel: SKLabelNode {
    static var score: Int? {
        set {
            guard let newHighScore = newValue else {
                return
            }
            if (score == nil && newHighScore != 0) || newHighScore > score ?? 0 {
                UserDefaults.standard.set(newHighScore, forKey: "HighestScore")
                UserDefaults.standard.synchronize()
            }
        }
        get {
            guard let saveHighScore = UserDefaults.standard.object(forKey: "HighestScore") as? Int else {
                return nil
            }
            return saveHighScore
        }
    }

    override init() {
        super.init()
        text = HighScoreLabel.score != nil ? "High score: \(HighScoreLabel.score ?? 0)" : nil
        zPosition = 2
        position = CGPoint(x: 0, y: UIScreen.main.bounds.height/6)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}

