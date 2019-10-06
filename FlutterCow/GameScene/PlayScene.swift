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
    private static var bounds = UIScreen.main.bounds

    static var spiderX: CGFloat {
        return CGFloat.random(in: -bounds.width/3...bounds.maxX + bounds.width/2)
    }
    static var spiderY: CGFloat {
        return CGFloat.random(in: 0...bounds.maxY)
    }
    static var logX: CGFloat {
        return CGFloat.random(in: 0...bounds.maxX)
    }
    static var logY: CGFloat {
        return CGFloat.random(in: bounds.midY...bounds.maxY)
    }
    static var coinX: CGFloat {
        return CGFloat.random(in: -bounds.width/2...0)
    }
    static var logHeight: CGFloat = bounds.height
}

class PlayScene: SKScene {
    var cow: Cow = Cow()

    var spider0: Spider!

    var spider1: Spider!
    
    var spider2: Spider!
    
    var spider3: Spider!

    var backgrounds: [Background] = []
    
    var log: Log!
    
    var coin: Coin!

    var newBackgroundNeeded: Bool = true

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        coin = Coin(position: CGPoint(x: Random.coinX, y: frame.height/2))
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
        addChild((coin))
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
            for contactedBody in cow.physicsBody?.allContactedBodies() ?? [] { // spider or post collision
                if contactedBody.contactTestBitMask == 0 {
                    cow.isDead = true
                    spider0.removeAllActions()
                    spider1.removeAllActions()
                    spider2.removeAllActions()
                    spider3.removeAllActions()
                    coin.removeAllActions()
                    log.removeAllActions()
                    for background in backgrounds {
                        if background.hasActions() {
                            background.removeAllActions()
                        }
                    }
                    isUserInteractionEnabled = false
                } else {    // coin collision
                    coin.removeFromParent()
                    coin = Coin(position: CGPoint(x: Random.coinX, y: frame.height/2))
                    addChild(coin)
                    break
                }
            }
        }
        
        /** collision bottom */
        if cow.position.y <= frame.minY+cow.size.height {
            deAlloc()
            for background in backgrounds {
                background.removeAllActions()
            }
            NotificationCenter.default.post(name: NSNotification.Name("game over"), object: nil)
        }
  
        // remove coin if out of frame
        if coin.position.x <= -frame.width/2 || coin.position.y >= frame.height/2 {
            coin.removeFromParent()
            coin = Coin(position: CGPoint(x: Random.coinX, y: frame.height/2))
            addChild(coin)
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
    
    func deAlloc() {
        for children in children {
            children.removeAllActions()
            children.removeFromParent()
        }
    }
}
