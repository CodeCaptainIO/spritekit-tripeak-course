//
//  TRIMenuScene.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/14/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIMenuScene: SKScene {

  private weak var background: TRIBackground?
  
  override func didMoveToView(view: SKView) {
    
    self.setupBackground()
    self.setupInterface()
    
  }
  
  private func setupInterface() {
    
    self.setupLogo()
    
  }
  
  private func setupLogo() {
    
    let lblTitle = TRIUnderlinedLabelNode(
      text: "Tripeak Solitaire",
      borderHeight: TRIMenuSceneLayout.titleBorderHeight,
      underlinedWidthPercentage: 0.5
    )
    lblTitle.position = CGPoint(
      x: self.size.width / 2,
      y: self.size.height - TRIMenuSceneLayout.titleYOffset
    )
    lblTitle.fontSize = TRIMenuSceneLayout.titleFontSize
    self.addChild(lblTitle)
    
    let suits = SKSpriteNode(imageNamed: "suits")
    suits.position = CGPoint(
      x: lblTitle.position.x,
      y: lblTitle.position.y + TRIMenuSceneLayout.suitsOffset
    )
    suits.size = CGSize(
      width: suits.size.width * 0.5,
      height: suits.size.height * 0.5
    )
    self.addChild(suits)
    
  }
  
  private func setupBackground() {
    let background = TRIBackground(size: self.size)
    self.addChild(background)
    self.background = background
  }
  
}
