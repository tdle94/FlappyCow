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
    var playButtonTexture: SKTexture {
        let image = UIImage(named: "play_button")!
        return SKTexture(image: image)
    }

    init() {
        super.init(texture: nil, color: .white, size: .zero)
        texture = playButtonTexture
        size = texture?.size() ?? .zero
        position = .zero
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("start game"), object: nil)
    }
}
