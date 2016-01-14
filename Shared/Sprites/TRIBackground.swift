//
//  TRIBackground.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/14/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIBackground: SKSpriteNode {

  private weak var background: SKSpriteNode!
  private weak var parallaxBackground: SKSpriteNode!
  
  init(size: CGSize) {
    
    super.init(texture: nil, color: SKColor.clearColor(), size: size)
    
    let background = SKSpriteNode(
      imageNamed: "bg"
    )
    background.zPosition = 0
    background.position = CGPoint(
      x: self.size.width / 2,
      y: self.size.height / 2
    )
    self.addChild(background)
    self.background = background
    
    let parallaxBackground = SKSpriteNode(
      imageNamed: "parallaxBackground"
    )
    parallaxBackground.zPosition = 0
    parallaxBackground.position = CGPoint(
      x: self.size.width / 2,
      y: self.size.height / 2
    )
    self.addChild(parallaxBackground)
    self.parallaxBackground = parallaxBackground
    
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
