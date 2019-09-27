//
//  GameScene.swift
//  FlutterCow
//
//  Created by Tuyen Le on 9/23/19.
//  Copyright © 2019 Tuyen Le. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayScene: SKScene {
    var cow: Cow = Cow()
    
    var backgrounds: [Background] = []
    
    var newBackgroundNeeded: Bool = true

    override func didMove(to view: SKView) {
      print("lsjflkdsjlfdjsl")
        addChild(cow)
        backgrounds.append(Background(size: frame.size))
        addChild(backgrounds.first!)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cow.moveUp()
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let leadingBackground = backgrounds.first else { return }
        if leadingBackground.frame.maxX <= (frame.maxX + frame.width/2) && newBackgroundNeeded {
            let newBackground = Background(size: frame.size)
            newBackground.position.x = leadingBackground.frame.maxX + frame.width/2.06
            backgrounds.append(newBackground)
            addChild(newBackground)
            newBackgroundNeeded = false
        } else if leadingBackground.frame.maxX <= -frame.size.width/2 {
            backgrounds.first?.removeFromParent()
            backgrounds.removeFirst()
            newBackgroundNeeded = true
        }
    }
}
