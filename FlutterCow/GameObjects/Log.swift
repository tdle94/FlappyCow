//
//  Log.swift
//  FlutterCow
//
//  Created by Tuyen Le on 9/28/19.
//  Copyright © 2019 Tuyen Le. All rights reserved.
//

import Foundation
import SpriteKit

class Log: SKSpriteNode {
    
    var randomHeight: CGFloat

    var logTexture: SKTexture {
        let image = UIImage(named: "Log/body")!
        let resize = image.resizeImageWith(newSize: CGSize(width: image.size.width, height: randomHeight))
        return SKTexture(image: resize)
    }

    init(position: CGPoint, randomHeight: CGFloat) {
        self.randomHeight = randomHeight
        super.init(texture: nil, color: .white, size: .zero)
        super.position = CGPoint(x: position.x, y: -UIScreen.main.bounds.height*2)
        super.texture = logTexture
        super.size = logTexture.size()

        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: randomHeight + 80), center: CGPoint(x: 50, y: 0))
        physicsBody?.affectedByGravity = false
        physicsBody?.mass = 1000
        physicsBody?.friction = 10
        physicsBody?.isDynamic = true

        zPosition = 2

        run(SKAction.repeatForever(SKAction.moveBy(x: -5, y: 0, duration: 0.07)))
        run(SKAction.moveTo(y: position.y, duration: 2))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
