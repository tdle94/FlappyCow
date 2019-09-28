//
//  GameScene.swift
//  FlutterCow
//
//  Created by Tuyen Le on 9/23/19.
//  Copyright © 2019 Tuyen Le. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayScene: SKScene {
    var cow: Cow = Cow()

    var spider0: Spider!

    var spider1: Spider!

    var backgrounds: [Background] = []
    
    var log: Log!

    var newBackgroundNeeded: Bool = true

    var randomY: CGFloat {
        return CGFloat.random(in: 0...frame.maxY*1.5)
    }
    
    var randomX: CGFloat {
        return CGFloat.random(in: 0...frame.maxX-100)
    }
    
    var logRandomX: CGFloat {
        return CGFloat.random(in: frame.maxX...frame.maxX*2)
    }
    
    var logRandomHeight: CGFloat {
        return CGFloat.random(in: 0...frame.height)
    }

    override func didMove(to view: SKView) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            log = Log(positionX: logRandomX, randomHeight: logRandomHeight)
        } else {
            log = Log(positionX: logRandomX, randomHeight: logRandomHeight)
        }

        spider0 = Spider(position: CGPoint(x: randomX, y: frame.maxY), randomDrop: CGPoint(x: 0, y: -randomY))
        spider1 = Spider(position: CGPoint(x: randomX, y: frame.maxY), randomDrop: CGPoint(x: 0, y: -randomY))
        addChild(cow)
        addChild(spider0)
        addChild(spider1)
        addChild(log)
        backgrounds.append(Background(size: frame.size))
        addChild(backgrounds.first!)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cow.moveUp()
    }

    override func update(_ currentTime: TimeInterval) {
        guard let leadingBackground = backgrounds.first else { return }

        // move background indefinitely
        if leadingBackground.frame.maxX <= (frame.maxX + frame.width/2) && newBackgroundNeeded {
            let newBackground = Background(size: frame.size)
            newBackground.position.x = leadingBackground.frame.maxX + frame.width/2.06
            backgrounds.append(newBackground)
            addChild(newBackground)
            newBackgroundNeeded = false
        } else if leadingBackground.frame.maxX <= -frame.size.width/2 {
            backgrounds.first?.removeFromParent()
            backgrounds.removeFirst()
            newBackgroundNeeded = true
        }
        
        // remove log if out of frame and add back to screen with new position
        if log.position.x <= -frame.width/2 {
            log.removeFromParent()
            log = Log(positionX: logRandomX, randomHeight: logRandomHeight)
            addChild(log)
        }

        // check for player collision
        
        /** collision top screen,  with spider or with log */
        if cow.position.y >= frame.maxY || cow.physicsBody?.allContactedBodies().count ?? 0 > 0 && !cow.isDead  {
            cow.isDead = true
            spider0.removeAllActions()
            spider1.removeAllActions()
            log.removeAllActions()
            for background in backgrounds {
                background.removeAllActions()
            }
            isUserInteractionEnabled = false
        }


        // remove spider if out of frame and add back to screen with new position
        if spider0.position.x <= -frame.width/2 {
            spider0.removeFromParent()
            spider0.web.removeFromParent()
            spider0 = Spider(position: CGPoint(x: randomX, y: frame.maxY), randomDrop: CGPoint(x: 0, y: -randomY))
            addChild(spider0)
        }

        if spider1.position.x <= -frame.width/2 {
            spider1.removeFromParent()
            spider1 = Spider(position: CGPoint(x: randomX, y: frame.maxY), randomDrop: CGPoint(x: 0, y: -randomY))
            addChild(spider1)
        }
    }
}
