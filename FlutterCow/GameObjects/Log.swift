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

    init(positionX: CGFloat, randomHeight: CGFloat) {
        self.randomHeight = randomHeight
        super.init(texture: nil, color: .white, size: .zero)
        super.position = CGPoint(x: positionX, y: -UIScreen.main.bounds.height/2)
        super.texture = logTexture
        super.size = logTexture.size()

        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width/4, height: size.height*1.06))
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false

        texture = logTexture
        size = logTexture.size()

        zPosition = 2

        run(SKAction.repeatForever(SKAction.moveBy(x: -5, y: 0, duration: 0.07)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
