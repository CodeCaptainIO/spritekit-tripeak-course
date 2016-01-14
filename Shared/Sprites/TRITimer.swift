//
//  TRITimer.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/14/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRITimer: SKNode {

  private weak var background: SKSpriteNode?
  private weak var foreground: SKSpriteNode?
  private var pct: CGFloat = 0.0
  
  var percentage: CGFloat {
    get {
      return self.pct
    }
  }
  
  var size: CGSize = CGSizeZero
  
  convenience init(size: CGSize) {
    
    self.init()
    self.size = size
    self.setup()
    
  }
  
  func setup() {
    let background = SKSpriteNode(
      color: SKColor.blackColor(),
      size: size
    )
    background.alpha = 0.3
    background.anchorPoint = CGPoint(
      x: 0,
      y: 1
    )
    self.addChild(background)
    self.background = background
    
    let foreground = SKSpriteNode(
      color: SKColor.whiteColor(),
      size: size
    )
    foreground.anchorPoint = CGPoint(
      x: 0,
      y: 1
    )
    self.addChild(foreground)
    self.foreground = foreground
  }
  
  func updateWithPercentage(percentage: CGFloat) {
    self.pct = percentage
    let xscale = 1 - percentage
    let action = SKAction.scaleXTo(xscale, duration: 0.1)
    self.foreground?.runAction(action)
  }
  
}
