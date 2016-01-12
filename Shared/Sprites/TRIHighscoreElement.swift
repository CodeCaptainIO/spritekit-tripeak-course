//
//  TRIHighscoreElement.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/12/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIHighscoreElement: SKNode, TRIHighscoreManagerDelegate {

  weak var textField: SKLabelNode?
  
  override init() {
    super.init()
    
    let textField = SKLabelNode(fontNamed: TRIGameSceneLayout.hudFont)
    textField.fontSize = TRIGameSceneLayout.hudFontSize
    textField.verticalAlignmentMode = .Center
    self.addChild(textField)
    self.textField = textField
    
    self.updateTextField()
    
  }
  
  func scoreUpdated(score: Int) {
    self.updateTextField()
  }

  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }
  
  func updateTextField() {
    self.textField?.text = "Score: \(TRIHighscoreManager.instance.formattedScore)"
  }
  
}
