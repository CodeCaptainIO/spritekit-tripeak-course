//
//  TRICardManager.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/11/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRICardManager: NSObject, TRICardDelegate {

  private var leftBlockingCard: TRICard?
  private var rightBlockingCard: TRICard?
  private var managingCard: TRICard?
  
  init(
    managingCard: TRICard,
    leftBlockingCard: TRICard,
    rightBlockingCard: TRICard) {
      super.init()
      
      self.leftBlockingCard = leftBlockingCard
      self.leftBlockingCard?.addSubscriber(self)
      self.rightBlockingCard = rightBlockingCard
      self.rightBlockingCard?.addSubscriber(self)
      
      self.managingCard = managingCard
      
  }
  
  func cardStatusChanged(card: TRICard) {
    self.update()
  }
  
  private func update() {
    if leftBlockingCard!.removed && rightBlockingCard!.removed {
      managingCard!.open = true
    }
  }
  
}
