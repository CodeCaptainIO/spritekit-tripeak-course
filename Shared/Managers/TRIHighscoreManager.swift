//
//  TRIHighscoreManager.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/12/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

protocol TRIHighscoreManagerDelegate: NSObjectProtocol {
  func scoreUpdated(score: Int)
}

class TRIHighscoreManager: NSObject {

  private var subscribers: [TRIHighscoreManagerDelegate] = []
  static var instance = TRIHighscoreManager()
  var formattedScore: String {
    get {
      let numberFormatter = NSNumberFormatter()
      numberFormatter.numberStyle = .DecimalStyle
      return numberFormatter.stringFromNumber(
        NSNumber(integer: self.score)
      )!
    }
  }
  var inverseMultiplier: CGFloat = 0
  var score: Int = 0 {
    didSet {
      print("Score: \(score)")
      self.notifySubscribers()
    }
  }
  
  func cardCleared() {
    print("Card Cleared")
    self.score += self.multiplied(125)
  }
  
  func peakCleared() {
    print("Peak Cleared")
    self.score += self.multiplied(1250)
  }
  
  func gameClearedWithRemainingCards(remainingCards: Int) {
    print("Game Cleared with \(remainingCards) remaining cards")
    self.score += self.multiplied(5000)
    if remainingCards > 0 {
      for i in 1...remainingCards {
        let num = Double(i) / 20.0
        self.score += self.multiplied( num * 250 )
      }
    }
  }
  
  func reset() {
    self.subscribers = []
    self.inverseMultiplier = 0
    self.score = 0
  }
  
  private func notifySubscribers() {
    for subscriber: TRIHighscoreManagerDelegate in subscribers {
      subscriber.scoreUpdated(score)
    }
  }
  
  private func multiplied(number: Double) -> Int {
    let num = number + number * Double(1 - inverseMultiplier)
    return Int(round(num / 5) * 5)
  }
  
  func addSubscriber(subscriber: TRIHighscoreManagerDelegate) {
    self.subscribers.append(subscriber)
  }
  
}
