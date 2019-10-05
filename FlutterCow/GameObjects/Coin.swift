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
        let goldAnimatedAtlas = SKTextureAtlas(named: "Gold")
        var textures: [SKTexture] = []

        for i in 1...6 {
            let goldTextureName = "gold_coin_hexagon_\(i)"
            textures.append(goldAnimatedAtlas.textureNamed(goldTextureName))
        }

        return textures
    }

    init(position: CGPoint) {
        super.init(texture: nil, color: .white, size: .zero)
        super.position = position
        texture = coinTextures[0]

        size = coinTextures[0].size()
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/3, center: CGPoint(x: size.width/2, y: size.height/2))
        physicsBody?.affectedByGravity = false
        physicsBody?.contactTestBitMask = 1

        zPosition = 2

        let rotatingAnimation = SKAction.animate(with: coinTextures, timePerFrame: 0.07, resize: false, restore: true)
        let rotatingAction = SKAction.moveBy(x: -10, y: -50, duration: 1)

        run(SKAction.repeatForever(rotatingAction))
        run(SKAction.repeatForever(rotatingAnimation))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
