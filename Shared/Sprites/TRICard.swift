//
//  TRICard.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/11/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRICard: SKNode {
  
  var open: Bool = false {
    didSet {
      self.handleOpenClosed()
    }
  }
  
  override var description: String {
    return "\(self.cardModel!.rank) of \(self.cardModel!.suit)"
  }
  
  var cardModel: TRICardModel?
  
  weak var front: SKSpriteNode?
  weak var back: SKSpriteNode?
  
  var size: CGSize = TRIGameSceneLayout.cardSize
  
  override init() {
    super.init()
  }

  init(cardModel: TRICardModel) {
    super.init()
    self.cardModel = cardModel
    
    let front = SKSpriteNode(
      imageNamed: cardModel.asset
    )
    front.size = size
    self.addChild(front)
    self.front = front
    
    let back = SKSpriteNode(
      imageNamed: self.cardBackWithColor(.Red, type: .Type4)
    )
    back.size = size
    self.addChild(back)
    self.back = back
    
    self.handleOpenClosed()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  private func cardBackWithColor(
    color: CardBackColor, type: CardBackType) -> String {
      return "cardBack_" + color.stringValue() + type.stringValue()
  }
  
  private func handleOpenClosed() {
    if open {
      self.front!.hidden = false
      self.back!.hidden = true
    } else {
      self.front!.hidden = true
      self.back!.hidden = false
    }
  }
  
}
