//
//  Cow.swift
//  FlutterCow
//
//  Created by Tuyen Le on 9/23/19.
//  Copyright © 2019 Tuyen Le. All rights reserved.
//

import Foundation
import SpriteKit

class Cow: SKSpriteNode {
    
    var isDead: Bool = false {
        didSet {
            if isDead {
                die()
            }
        }
    }

    var fallTextures: [SKTexture] {
        let cowAnimatedAtlas = SKTextureAtlas(named: "Cow Sprites")
        var textures: [SKTexture] = []

        for i in 0...15 {
            let cowTextureName = "cow\(i)"
            textures.append(cowAnimatedAtlas.textureNamed(cowTextureName))
        }

        return textures
    }

    var flyTextures: [SKTexture] {
        let cowAnimatedAtlas = SKTextureAtlas(named: "Cow Sprites")
        var textures: [SKTexture] = []

        for i in 16...23 {
            let cowTextureName = "cow\(i)"
            textures.append(cowAnimatedAtlas.textureNamed(cowTextureName))
        }

        return textures
    }
    
    var dieTextures: [SKTexture] {
        let cowAnimatedAtlas = SKTextureAtlas(named: "Cow Sprites")
        var textures: [SKTexture] = []

        for i in 24...31 {
            let cowTextureName = "cow\(i)"
            textures.append(cowAnimatedAtlas.textureNamed(cowTextureName))
        }

        return textures
    }

    init() {
        super.init(texture: nil, color: .clear, size: .zero)
        texture = dieTextures[4]
        size = fallTextures[0].size()
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/3, center: CGPoint(x: frame.size.width/2, y: frame.size.height/2))
        physicsBody?.affectedByGravity = false
        physicsBody?.friction = 10
        physicsBody?.linearDamping = 10
        physicsBody?.mass = 100
        physicsBody?.isDynamic = true
        physicsBody?.contactTestBitMask = 0
        physicsBody?.categoryBitMask = 1
        position.x = -frame.width*2
        zPosition = 2

        let flydownAnimation = SKAction.animate(with: fallTextures, timePerFrame: 0.07, resize: false, restore: true)
        let flydownAction = SKAction.moveBy(x: 0, y: -10, duration: 0.07)
        flydownAnimation.timingMode = .easeOut

        run(SKAction.repeatForever(flydownAnimation))
        run(SKAction.repeatForever(flydownAction))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func moveUp() {
        let flyupAction = SKAction.moveBy(x: 0, y: 80, duration: 0.07)
        let flyupAnimation = SKAction.animate(with: flyTextures, timePerFrame: 0.07)
        flyupAnimation.timingMode = .easeOut
        flyupAction.timingMode = .easeOut

        run(flyupAction)
        run(flyupAnimation)
    }
    
    private func die() {
        let dieAnimation = SKAction.animate(with: dieTextures, timePerFrame: 0.07, resize: false, restore: true)
        let dieAction = SKAction.moveBy(x: 5, y: -20, duration: 0.07)
        dieAction.timingMode = .easeOut
        dieAnimation.timingMode = .easeOut
        removeAllActions()
        run(SKAction.repeatForever(dieAnimation))
        run(SKAction.repeatForever(dieAction))
    }
}
