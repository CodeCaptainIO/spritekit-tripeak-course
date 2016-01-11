//
//  TRICard.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/11/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

protocol TRICardDelegate {
  func cardStatusChanged(card: TRICard)
}

class TRICard: SKNode {
  
  var manager: TRICardManager?
  
  var clickable: Bool = true
  var removed: Bool = false {
    didSet {
      if removed {
        self.clickable = false
      }
    }
  }
  
  var open: Bool = false {
    didSet {
      self.handleOpenClosed()
    }
  }
  
  override var description: String {
    return "\(self.cardModel!.rank) of \(self.cardModel!.suit)"
  }
  
  var cardModel: TRICardModel?
  
  private var subscribers: [TRICardDelegate] = []
  
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
      self.clickable = true
      self.front!.hidden = false
      self.back!.hidden = true
    } else {
      self.clickable = false
      self.front!.hidden = true
      self.back!.hidden = false
    }
  }
  
  func remove() {
    // Temporary
    self.removeFromParent()
    self.removed = true
    self.notifySubscribers()
  }
  
  func notifySubscribers() {
    for subscriber: TRICardDelegate in self.subscribers {
      subscriber.cardStatusChanged(self)
    }
  }
  
  func addSubscriber(subscriber: TRICardDelegate) {
    self.subscribers.append(subscriber)
  }
  
  private func updateAnimationWithScale(scale: CGFloat, element: SKNode) {
    element.xScale = scale
    element.yScale = scale
    let scaleAction = SKAction.scaleTo(1, duration: 0.2)
    element.runAction(scaleAction)
  }
  
  func flip() {
    if self.open {
      return
    }
    self.clickable = true
    
    let scaleXAction = SKAction.scaleXTo(
      0.05,
      duration: 0.225
    )
    let scaleYAction = SKAction.scaleYTo(
      1.3,
      duration: 0.225
    )
    let groupAction = SKAction.group(
      [scaleXAction, scaleYAction]
    )
    self.back!.runAction(groupAction, completion: { () -> Void in
      self.open = true
      self.updateAnimationWithScale(1.25, element: self.front!)
    })
    
  }
  
}
