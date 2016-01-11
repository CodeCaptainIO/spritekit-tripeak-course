//
//  TRICard.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/11/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRICard: SKNode {
  
  var cardModel: TRICardModel?
  weak var front: SKSpriteNode?
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
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}
