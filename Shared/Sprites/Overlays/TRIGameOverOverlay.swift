//
//  TRIGameOverOverlay.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/14/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIGameOverOverlay: TRIBaseOverlay {

  private weak var lblTitle: SKLabelNode!
  private weak var lblSubtitle: SKLabelNode!
  
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
      x: self.center.x,
      y: self.center.y + TRIOverlayLayout.titleYOffset
    )
    lblTitle.fontSize = TRIOverlayLayout.titleFontSize
    self.addChild(lblTitle)
    self.lblTitle = lblTitle
    
    let lblSubtitle = SKLabelNode(
      fontNamed: Fonts.HelveticaNeueLight.rawValue
    )
    lblSubtitle.position = CGPoint(
      x: self.center.x,
      y: self.center.y - 40 + TRIOverlayLayout.subTitleYOffset
    )
    lblSubtitle.fontSize = TRIOverlayLayout.subTitleFontSize
    self.addChild(lblSubtitle)
    self.lblSubtitle = lblSubtitle
  }
  
  func show(withTitle title: String, subtitle: String, closure: (() -> Void)?) {
    
    lblTitle.text = title
    lblSubtitle.text = subtitle
    
    self.animateElementUp(
      self.lblTitle,
      endPosition: center,
      completion: nil
    )
    
    self.fadeIn(self.lblSubtitle, delay: 0.8) { () -> Void in
      if let closure = closure {
        closure()
      }
    }
    
    self.fadeInBackground()
    
    self.hidden = false
    
  }
  
}
