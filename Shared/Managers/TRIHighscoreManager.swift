//
//  TRIHighscoreManager.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/12/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIHighscoreManager: NSObject {

  static var instance = TRIHighscoreManager()
  var inverseMultiplier: CGFloat = 0
  var score: Int = 0 {
    didSet {
      print("Score: \(score)")
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
    self.inverseMultiplier = 0
    self.score = 0
  }
  
  private func multiplied(number: Double) -> Int {
    let num = number + number * Double(1 - inverseMultiplier)
    return Int(round(num / 5) * 5)
  }
  
}
