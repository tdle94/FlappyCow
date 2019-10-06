//
//  SplashScene.swift
//  FlutterCow
//
//  Created by Tuyen Le on 10/6/19.
//  Copyright © 2019 Tuyen Le. All rights reserved.
//

import SpriteKit
import GameplayKit

class SplashScene: SKScene {
    var background: Background {
        let background = Background(size: frame.size)
        background.removeAllActions()
        return background
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        addChild(background)
        addChild(PlayButton())
    }
}
