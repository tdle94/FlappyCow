//
//  GameViewController.swift
//  FlutterCow
//
//  Created by Tuyen Le on 9/23/19.
//  Copyright © 2019 Tuyen Le. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class PlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(startGame),
                                                   name: NSNotification.Name("start game"),
                                                   object: nil)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(gameOver),
                                                   name: NSNotification.Name("game over"),
                                                   object: nil)

            if let scene = SKScene(fileNamed: "SplashScene") {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    @objc func startGame() {
        guard let view = self.view as? SKView, let scene = SKScene(fileNamed: "PlayScene") else { return }
        scene.scaleMode = .fill
        view.scene?.removeFromParent()
        view.presentScene(scene, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
    }
    
    @objc func gameOver() {
        guard let view = self.view as? SKView, let scene = SKScene(fileNamed: "SplashScene") else { return }
        scene.scaleMode = .fill
        view.scene?.removeFromParent()
        view.presentScene(scene, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
    }
}
