//
//  Spider.swift
//  FlutterCow
//
//  Created by Tuyen Le on 9/28/19.
//  Copyright © 2019 Tuyen Le. All rights reserved.
//

import Foundation
import SpriteKit

class Spider: SKSpriteNode {

    let randomDrop: CGPoint

    let spiderTexture = SKTexture(imageNamed: "Spider/spider")

    var web: SKSpriteNode {
        let image = UIImage(named: "Spider/web")!
        let resize = image.resizeImageWith(newSize: CGSize(width: image.size.width, height: UIScreen.main.bounds.height))
        let texture = SKTexture(image: resize)
        let node = SKSpriteNode(texture: texture)
        node.position = CGPoint(x: -2, y: UIScreen.main.bounds.height/2 + frame.height/2)
        return node
    }

    init(position: CGPoint, randomDrop: CGPoint) {
        self.randomDrop = randomDrop
        super.init(texture: spiderTexture, color: .white, size: spiderTexture.size())
        super.position = position

        physicsBody = SKPhysicsBody(circleOfRadius: size.width/3, center: CGPoint(x: size.width/2, y: size.height/2))
        physicsBody?.affectedByGravity = false

        zPosition = 2

        addChild(web)
        run(SKAction.moveBy(x: 0, y: randomDrop.y, duration: 2))
        run(SKAction.repeatForever(SKAction.moveBy(x: -5, y: 0, duration: 0.07)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
