//
//  TRIUnderlinedLabelNode.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/14/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIUnderlinedLabelNode: SKLabelNode {

  var borderHeight: CGFloat = 0.0
  
  var underlinedWidthPercentage: CGFloat = 0.0 {
    didSet {
      self.updateUnderline()
    }
  }
  
  private weak var underline: SKSpriteNode?
  
  override var fontSize: CGFloat {
    didSet {
      self.updateUnderline()
    }
  }
  
  convenience init(
    text: String,
    borderHeight: CGFloat,
    underlinedWidthPercentage: CGFloat
    ) {
      self.init()
      
      self.fontName = Fonts.HelveticaNeueLight.rawValue
      
      self.text = text
      
      self.borderHeight = borderHeight
      
      self.underlinedWidthPercentage = underlinedWidthPercentage
      
      let underline = SKSpriteNode(
        color: SKColor.whiteColor(),
        size: CGSize(
          width: self.frame.size.width * underlinedWidthPercentage,
          height: borderHeight
        )
      )
      underline.position = CGPoint(
        x: underline.position.x,
        y: underline.position.y - 10
      )
      self.addChild(underline)
      self.underline = underline
      
  }
  
  func updateUnderline() {
    self.underline!.size = CGSize(
      width: self.frame.size.width * underlinedWidthPercentage,
      height: borderHeight
    )
  }
  
}
