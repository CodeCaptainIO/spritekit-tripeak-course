//
//  TRIGameFlowManager.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/11/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIGameFlowManager: NSObject {

  private weak var gameScene: TRIGameScene?
  
  var currentCard: TRICard? {
    get {
      return self.gameScene!.currentCard
    }
    set {
      self.gameScene!.currentCard = newValue
    }
  }
  
  var peakCards: [TRICard] {
    get {
      let peak = leftPeak + centerPeak + rightPeak
      return peak.sort({ (cardA: TRICard, cardB: TRICard) -> Bool in
        return cardA.position.y < cardB.position.y
      })
    }
  }
  
  var leftPeak: [TRICard] {
    get {
      return self.gameScene!.leftPeak
    }
    set {
      self.gameScene!.leftPeak = newValue
    }
  }
  
  var centerPeak: [TRICard] {
    get {
      return self.gameScene!.centerPeak
    }
    set {
      self.gameScene!.centerPeak = newValue
    }
  }
  
  var rightPeak: [TRICard] {
    get {
      return self.gameScene!.rightPeak
    }
    set {
      self.gameScene!.rightPeak = newValue
    }
  }
  
  init(gameScene: TRIGameScene) {
    super.init()
    self.gameScene = gameScene
  }
  
  func handleTouchStart(point: CGPoint) {
    for card: TRICard in self.peakCards {
      if card.containsPoint(point) && card.clickable {
        
        if self.validateCardAgainstCurrentCard(card.cardModel!) {
          card.remove()
          
          let position = CGPoint(
            x: self.currentCard!.finalPosition!.x + TRIGameSceneLayout.openCardOffset,
            y: self.currentCard!.finalPosition!.y
          )
          card.finalPosition = position
          
          let animation = SKAction.moveTo(position, duration: 0.2)
          animation.timingMode = .EaseOut
          card.runAction(animation)
          card.zPosition = self.currentCard!.zPosition + 1
          
          self.gameScene!.currentCard = card
          
          self.removeCardFromPeak(&self.leftPeak, card: card)
          self.removeCardFromPeak(&self.centerPeak, card: card)
          self.removeCardFromPeak(&self.rightPeak, card: card)
          
        }
        
        return
        
      }
    }
    let optionalTopCard = self.gameScene!.cardDeckGraphics.last
    if let topCard = optionalTopCard {
      if topCard.containsPoint(point) {
        let position = CGPoint(
          x: self.currentCard!.finalPosition!.x + TRIGameSceneLayout.openCardOffset,
          y: self.currentCard!.finalPosition!.y
        )
        topCard.finalPosition = position
        let animation = SKAction.moveTo(position, duration: 0.2)
        animation.timingMode = .EaseOut
        topCard.flip()
        topCard.runAction(animation)
        topCard.zPosition = self.currentCard!.zPosition + 1
        self.gameScene!.currentCard = topCard
        let cardIndex = self.gameScene!.cardDeckGraphics.indexOf(topCard)
        self.gameScene!.cardDeckGraphics.removeAtIndex(cardIndex!)
      }
    }
  }
  
  private func validateCardAgainstCurrentCard(cardModel: TRICardModel) -> Bool {
    
    if cardModel.rank.rawValue == currentCard!.cardModel!.rank.rawValue + 1 {
      return true
    }
    
    if cardModel.rank.rawValue == currentCard!.cardModel!.rank.rawValue - 1 {
      return true
    }
    
    if currentCard!.cardModel!.rank == .Ace {
      if cardModel.rank == .King {
        return true
      }
    }
    
    if currentCard!.cardModel!.rank == .King {
      if cardModel.rank == .Ace {
        return true
      }
    }
    
    return false
  }
  
  private func removeCardFromPeak(inout peak: [TRICard], card: TRICard) {
    if let index = peak.indexOf(card) {
      peak.removeAtIndex(index)
    }
  }
  
}
