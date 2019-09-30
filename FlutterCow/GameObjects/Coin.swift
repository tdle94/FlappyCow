//
//  Coin.swift
//  FlutterCow
//
//  Created by Tuyen Le on 9/29/19.
//  Copyright © 2019 Tuyen Le. All rights reserved.
//

import Foundation
import SpriteKit

class Coin: SKSpriteNode {
    var coinTextures: [SKTexture] {
        var textures: [SKTexture] = []

        for i in 1...30 {
            let coinTextureName = "Gold_\(i)"
            let image = UIImage(named: coinTextureName)!
            let resize = image.resizeCoin(newSize: CGSize(width: 50, height: 50))
            textures.append(SKTexture(image: resize))
        }

        return textures
    }

    init(position: CGPoint) {
        super.init(texture: nil, color: .white, size: .zero)
        super.position = position
        texture = coinTextures[0]
        size = coinTextures[0].size()
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2, center: CGPoint(x: size.width/2, y: size.height/2))
        physicsBody?.affectedByGravity = false
        physicsBody?.friction = 1
        physicsBody?.mass = 5

        zPosition = 2

        let rotatingAnimation = SKAction.animate(with: coinTextures, timePerFrame: 0.07, resize: false, restore: true)
        let rotatingAction = SKAction.moveBy(x: -20, y: -20, duration: 1)

        run(SKAction.repeatForever(rotatingAnimation))
        run(SKAction.repeatForever(rotatingAction))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
