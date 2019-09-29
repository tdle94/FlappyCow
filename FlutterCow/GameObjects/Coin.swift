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
        let coinAnimatedAtlas = SKTextureAtlas(named: "Coin")
        var textures: [SKTexture] = []

        for i in 0...15 {
            let coinTextureName = "Gold_\(i)"
            textures.append(coinAnimatedAtlas.textureNamed(coinTextureName))
        }

        return textures
    }

    init(position: CGPoint) {
        super.init(texture: nil, color: .white, size: .zero)
        texture = coinTextures[0]
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
