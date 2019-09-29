//
//  GameScene.swift
//  FlutterCow
//
//  Created by Tuyen Le on 9/23/19.
//  Copyright © 2019 Tuyen Le. All rights reserved.
//

import SpriteKit
import GameplayKit

struct Random {
    static var spiderX: CGFloat {
        return CGFloat.random(in: 0...UIScreen.main.bounds.maxX)
    }
    static var spiderY: CGFloat {
        return CGFloat.random(in: 0...UIScreen.main.bounds.maxY)
    }
    static var logX: CGFloat {
        return CGFloat.random(in: 0...UIScreen.main.bounds.maxX)
    }
    static var logY: CGFloat {
        return CGFloat.random(in: UIScreen.main.bounds.midY...UIScreen.main.bounds.maxY)
    }
    static var logHeight: CGFloat = UIScreen.main.bounds.height
}

class PlayScene: SKScene {
    var cow: Cow = Cow()

    var spider0: Spider!

    var spider1: Spider!
    
    var spider2: Spider!
    
    var spider3: Spider!

    var backgrounds: [Background] = []
    
    var log: Log!

    var newBackgroundNeeded: Bool = true

    override func didMove(to view: SKView) {
        log = Log(position: CGPoint(x: Random.logX, y: -Random.logY), randomHeight: Random.logHeight)
        spider0 = Spider(position: CGPoint(x: Random.spiderX, y: frame.maxY), randomDrop: CGPoint(x: 0, y: -Random.spiderY))
        spider1 = Spider(position: CGPoint(x: Random.spiderX, y: frame.maxY), randomDrop: CGPoint(x: 0, y: -Random.spiderY))
        spider2 = Spider(position: CGPoint(x: Random.spiderX, y: frame.maxY), randomDrop: CGPoint(x: 0, y: -Random.spiderY))
        spider3 = Spider(position: CGPoint(x: Random.spiderX, y: frame.maxY), randomDrop: CGPoint(x: 0, y: -Random.spiderY))
        addChild(cow)
        addChild(spider0)
        addChild(spider1)
        addChild(spider2)
        addChild(spider3)
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
            log = Log(position: CGPoint(x: Random.logX, y: -Random.logY), randomHeight: Random.logHeight)
            addChild(log)
        }

        // check for player collision

        /** collision top screen,  with spider or with log */
        if (cow.position.y >= frame.maxY || cow.physicsBody?.allContactedBodies().count ?? 0 > 0) && !cow.isDead  {
            cow.isDead = true
            spider0.removeAllActions()
            spider1.removeAllActions()
            spider2.removeAllActions()
            spider3.removeAllActions()
            log.removeAllActions()
            for background in backgrounds {
                background.removeAllActions()
            }
            isUserInteractionEnabled = false
        }
        
        /** collision bottom */
        if cow.position.y <= frame.minY+cow.size.height {
            cow.removeAllActions()
            spider0.removeAllActions()
            spider1.removeAllActions()
            spider2.removeAllActions()
            spider3.removeAllActions()
            log.removeAllActions()
            for background in backgrounds {
                background.removeAllActions()
            }
        }


        // remove spider if out of frame and add back to screen with new position

        if spider0.position.x <= -frame.width/2 {
            spider0.removeFromParent()
            spider0.web.removeFromParent()
            spider0 = Spider(position: CGPoint(x: Random.spiderX, y: frame.maxY), randomDrop: CGPoint(x: 0, y: -Random.spiderY))
            addChild(spider0)
        }

        if spider1.position.x <= -frame.width/2 {
            spider1.removeFromParent()
            spider1 = Spider(position: CGPoint(x: Random.spiderX, y: frame.maxY), randomDrop: CGPoint(x: 0, y: -Random.spiderY))
            addChild(spider1)
        }
        
        if spider2.position.x <= -frame.width/2 {
            spider2.removeFromParent()
            spider2 = Spider(position: CGPoint(x: Random.spiderX, y: frame.maxY), randomDrop: CGPoint(x: 0, y: -Random.spiderY))
            addChild(spider2)
        }

        if spider3.position.x <= -frame.width/2 {
            spider3.removeFromParent()
            spider3 = Spider(position: CGPoint(x: Random.spiderX, y: frame.maxY), randomDrop: CGPoint(x: 0, y: -Random.spiderY))
            addChild(spider3)
        }
    }
}
