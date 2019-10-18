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

    // MARK: - Game Objects

    var cow: Cow = Cow()

    var backgrounds: [Background] = []
    
    lazy var coin: Coin = {
       return Coin(position: CGPoint(x: Random.coinX, y: frame.height/2))
    }()
    
    lazy var scoreLabel: ScoreLabel! = {
       return ScoreLabel(text: "0", position: CGPoint(x: -frame.size.width/2 + 50, y: frame.size.height/2 - 50))
    }()

    var newBackgroundNeeded: Bool = true
  
    var timer: Timer = Timer()
  
    var maximumObstacles: Int = 2
  
    var numberOfTimeObstacleSpawn = 1

    // MARK: - Override funcs

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        let randomLogX = Random.logX
        let randomLogY = Random.logY
        let log = Log(position: CGPoint(x: randomLogX, y: -randomLogY), randomHeight: Random.logHeight)
        let spider = Spider(position: CGPoint(x: randomLogX, y: frame.maxY), randomDrop: CGPoint(x: 0, y: -randomLogY))

        addChild(cow)
        addChild(spider)
        addChild(log)
        addChild(coin)
        addChild(scoreLabel)
        backgrounds.append(Background(size: frame.size))
        addChild(backgrounds.first!)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cow.moveUp()
    }

    override func update(_ currentTime: TimeInterval) {
        timer.updateTimer(currentTime: currentTime)
        if !cow.isDead {
            handleCow()
            moveBackgroundIndefinitely()
            handleCoin()
            handleLogAndSpider()
        } else {
            if Int(timer.previousUpdateTime) % 5 == 0 {
                NotificationCenter.default.post(name: NSNotification.Name("game over"), object: nil)
            }
        }
    }

    // MARK: Custom funcs

    private func handleCoin() {
      // remove if out of frame
      if coin.position.x <= -frame.width/2 || coin.position.y >= frame.maxY + frame.size.height/2 {
          coin.removeFromParent()
          coin = Coin(position: CGPoint(x: Random.coinX, y: frame.height/2))
          addChild(coin)
      }
    }
  
  private func handleLogAndSpider() {
        // remove if out of frame. Because log and spider has approximately the same x position. Only check for log
        for node in children {
            if let log = node as? Log {
                if log.position.x <= -frame.width/2 {
                    log.removeFromParent()
                    numberOfTimeObstacleSpawn -= 1
                }
            }
        }
    }
  
    private func spawnSpiderAndLog() {
        guard numberOfTimeObstacleSpawn < maximumObstacles else {
            return
        }

        // if new log obstacle overlap the old one. Continue to look for new position
        let randomLogX = Random.logX
        let randomLogY = Random.logY
        let log = Log(position: CGPoint(x: randomLogX, y: -randomLogY), randomHeight: Random.logHeight)
        let spider = Spider(position: CGPoint(x: randomLogX, y: frame.maxY), randomDrop: CGPoint(x: 0, y: -randomLogY))

            
        for node in children {
            if let currentLog = node as? Log {
                if (log.frame.maxX >= currentLog.frame.minX && log.frame.maxX <= currentLog.frame.maxX) {
                    log.position.x -= log.frame.maxX - currentLog.frame.minX
                    spider.position.x -= log.frame.maxX - currentLog.frame.minX
                    break
                } else if (log.frame.minX >= currentLog.frame.minX && log.frame.minX <= currentLog.frame.maxX) {
                    log.position.x += currentLog.frame.maxX - log.frame.minX
                    spider.position.x += currentLog.frame.maxX - log.frame.minX
                    break
                }
            }
        }
        
        addChild(log)
        addChild(spider)
        numberOfTimeObstacleSpawn += 1
    }

  
    private func handleCow() {
        // spawn new log and spider if cow passed
      
        for node in children {
          if let spider = node as? Spider {
            if cow.position.x > spider.position.x {
              spawnSpiderAndLog()
            }
          }
        }
  
        // check for cow collision

        /** collision top screen,  with spider or with log */

        if (cow.position.y >= frame.maxY || cow.physicsBody?.allContactedBodies().count ?? 0 > 0) && !cow.isDead  {
            for contactedBody in cow.physicsBody?.allContactedBodies() ?? [] { // spider or post collision
                if contactedBody.contactTestBitMask == 0 {
                    cow.isDead = true
                    isUserInteractionEnabled = false
                    removeObstacleAction()
                } else {    // coin collision
                    cow.numberOfCoinAte += 1
                    scoreLabel.text = "\(cow.numberOfCoinAte)"
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
      
    }
  
    private func moveBackgroundIndefinitely() {
        guard let leadingBackground = backgrounds.first else { return }
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
    }
  
    private func removeObstacleAction() {
        for node in children {
          if let _ = node as? Cow {
            continue
          }
          node.removeAllActions()
        }
    }

    private func deAlloc() {
        for children in children {
            children.removeAllActions()
            children.removeFromParent()
        }
    }
}

extension PlayScene {
  enum Random {
      private static var bounds = UIScreen.main.bounds

      static var logX: CGFloat {
        return CGFloat.random(in: -bounds.width/2...bounds.maxX)
      }

      static var logY: CGFloat {
          return CGFloat.random(in: bounds.midY...bounds.maxY)
      }

      static var coinX: CGFloat {
          return CGFloat.random(in: -bounds.width/2...0)
      }

      static var logHeight: CGFloat = bounds.height
  }
}
