//
//  ScoreLabel.swift
//  FlutterCow
//
//  Created by Tuyen Le on 10/13/19.
//  Copyright © 2019 Tuyen Le. All rights reserved.
//

import Foundation
import SpriteKit

class ScoreLabel: SKLabelNode {
    init(text: String?, position: CGPoint) {
        super.init()
        fontName = "TimesNewRomanPS-BoldMT"
        fontSize = 50
        self.text = text
        zPosition = 2
        color = .white
        self.position = position
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
