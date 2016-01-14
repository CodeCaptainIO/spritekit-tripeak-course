//
//  TRIPauseOverlay.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/14/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIPauseOverlay: TRIBaseOverlay {

  weak var btnResume: TRIWireButton?
  weak var btnMenu: TRIWireButton?
  private weak var lblTitle: SKLabelNode?
  
  override init(withSize size: CGSize) {
    super.init(withSize: size)
    self.setup()
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    
    let lblTitle = SKLabelNode(
      fontNamed: Fonts.HelveticaNeueLight.rawValue
    )
    lblTitle.position = CGPoint(
      x: self.sizeReference.width / 2,
      y: self.sizeReference.height / 2
    )
    lblTitle.fontSize = TRIOverlayLayout.titleFontSize
    lblTitle.text = "Game Paused"
    self.addChild(lblTitle)
    self.lblTitle = lblTitle
    
    let btnResume = TRIWireButton(
      color: SKColor.whiteColor(),
      size: TRIOverlayLayout.btnResumeSize,
      title: "Resume Game"
    )
    self.addChild(btnResume)
    btnResume.zPosition = 9999999
    var yOffset = self.sizeReference.height / 2
    yOffset -= TRIOverlayLayout.btnResumeOffset
    btnResume.position = CGPoint(
      x: self.sizeReference.width / 2,
      y: yOffset
    )
    btnResume.userInteractionEnabled = true
    btnResume.label.fontSize = TRIOverlayLayout.buttonFontSize
    self.btnResume = btnResume
    
    let btnMenu = TRIWireButton(
      color: SKColor.whiteColor(),
      size: TRIOverlayLayout.btnMenuSize,
      title: "Quit"
    )
    self.addChild(btnMenu)
    btnMenu.zPosition = 9999999
    yOffset = self.btnResume!.position.y
    yOffset -= self.btnResume!.size.height / 2
    yOffset -= TRIOverlayLayout.btnResumeOffset
    btnMenu.position = CGPoint(
      x: self.sizeReference.width / 2,
      y: yOffset
    )
    btnMenu.userInteractionEnabled = true
    btnMenu.label.fontSize = TRIOverlayLayout.buttonFontSize
    self.btnMenu = btnMenu
    
  }
  
  func showPauseScreen(closure: (() -> Void)?) {
    
    self.lblTitle?.removeAllActions()
    self.btnMenu?.removeAllActions()
    self.btnResume?.removeAllActions()
    
    let position = CGPoint(
      x: self.sizeReference.width / 2,
      y: self.sizeReference.height / 2 + 50
    )
    self.btnResume?.alpha = 0
    self.btnMenu?.alpha = 0
    
    self.fadeInBackground()
    
    self.animateElementUp(self.lblTitle!, endPosition: position) { () -> Void in
      
      self.fadeIn(
        self.btnResume!,
        delay: 0,
        completion: nil
      )
      
      self.fadeIn(
        self.btnMenu!,
        delay: 0.2,
        completion: nil
      )
      
      if let closure = closure {
        closure()
      }
      
    }
    
    self.hidden = false
    
  }
  
}
