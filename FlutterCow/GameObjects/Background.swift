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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
           let size = image.size

           let heightRatio = targetSize.height / size.height

           // Figure out what our orientation is, and use that to form the rectangle
           let newSize: CGSize = CGSize(width: size.width, height: size.height * heightRatio)

           // This is the rect that we've calculated out and this is what is actually used below
           let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

           // Actually do the resizing to the rect using the ImageContext stuff
           UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
           image.draw(in: rect)
           let newImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()

           return newImage!
       }
}
