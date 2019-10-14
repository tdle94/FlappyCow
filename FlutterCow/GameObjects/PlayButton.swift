//
//  PlayButton.swift
//  FlutterCow
//
//  Created by Tuyen Le on 10/6/19.
//  Copyright © 2019 Tuyen Le. All rights reserved.
//

import Foundation
import SpriteKit

class PlayButton: SKSpriteNode {
    init() {
        let textureAtlas = SKTextureAtlas(named: "Buttons")
        super.init(texture: textureAtlas.textureNamed("play_button"), color: .white, size: .zero)
        size = texture?.size() ?? .zero
        position = .zero
        zPosition = 2
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("start game"), object: nil)
    }
}
