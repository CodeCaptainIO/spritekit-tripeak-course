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
      if card.containsPoint(point) {
        
        card.remove()
        
        self.removeCardFromPeak(&self.leftPeak, card: card)
        self.removeCardFromPeak(&self.centerPeak, card: card)
        self.removeCardFromPeak(&self.rightPeak, card: card)
        
        return
        
      }
    }
  }
  
  private func removeCardFromPeak(inout peak: [TRICard], card: TRICard) {
    if let index = peak.indexOf(card) {
      peak.removeAtIndex(index)
    }
  }
  
}
