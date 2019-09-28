//
//  Background.swift
//  FlutterCow
//
//  Created by Tuyen Le on 9/26/19.
//  Copyright © 2019 Tuyen Le. All rights reserved.
//

import Foundation
import SpriteKit

class Background: SKSpriteNode {

    init(size: CGSize) {
        super.init(texture: nil, color: .white, size: size)
        let image = UIImage(named: "background")!
        texture = SKTexture(image: image)
        run(SKAction.repeatForever(SKAction.moveBy(x: -5, y: 0, duration: 0.07)))
        if UIDevice.current.userInterfaceIdiom == .pad {
            position.y = 150
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
