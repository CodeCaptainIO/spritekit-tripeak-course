//
//  TRIGameSetupManager.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/11/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIGameSetupManager: NSObject {
  
  private var cardDeckGraphics: [TRICard] {
    get {
      return self.gameScene!.cardDeckGraphics
    }
    set {
      self.gameScene!.cardDeckGraphics = newValue
    }
  }
  
  private var leftOrderedPeakRows: [[TRICard]] = []
  private var centerOrderedPeakRows: [[TRICard]] = []
  private var rightOrderedPeakRows: [[TRICard]] = []
  
  private var openCards: [TRICard] = []
  
  private weak var gameScene: TRIGameScene?
  private var cardDeck: [TRICardModel] = []
  
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
  
  func setup() {
    self.createDeck()
    self.setupTripeak()
    self.splitPeaksIntoRows()
    let animatedOrder = self.prepareAnimatedDealing()
    self.animateWithOrderedCards(animatedOrder)
    self.setupCardManagers()
    self.deckSetup()
  }
  
  private func animateWithOrderedCards(cards: [TRICard]) {
    
    var i: Int = 1
    var zpos: CGFloat = 1000
    for card: TRICard in cards {
      
      let last: Bool = i == cards.count - 1
      
      let delayAction = SKAction.waitForDuration(Double(i) * 0.05)
      let animatingAction = SKAction.moveTo(
        card.finalPosition!,
        duration: 0.4
      )
      animatingAction.timingMode = .EaseOut
      
      let secondDelayAction = SKAction.waitForDuration(0.1)
      
      let sequence = SKAction.sequence(
        [
          delayAction, animatingAction, secondDelayAction
        ]
      )
      
      let zposDelay = SKAction.waitForDuration(Double(i) * 0.055)
      card.runAction(zposDelay, completion: { () -> Void in
        card.zPosition = zpos++
      })
      
      card.runAction(sequence, completion: { () -> Void in
        
        if self.openCards.contains(card) {
          card.flip()
        }
        
        if last {
          let delayAction = SKAction.waitForDuration(0.25)
          self.gameScene!.runAction(delayAction, completion: { () -> Void in
            self.openUpCurrentCard()
          })
        }
        
      })
      
      i++
      
    }
    
  }
  
  private func deckSetup() {
    
    for i in 0..<self.cardDeck.count {
      let card = TRICard(cardModel: self.getRandomCard())
      card.position = CGPoint(
        x: TRIGameSceneLayout.deckPosition.x,
        y: TRIGameSceneLayout.deckPosition.y + CGFloat(i) / 5
      )
      self.gameScene!.addChild(card)
      self.cardDeckGraphics.append(card)
    }
    
  }
  
  private func openUpCurrentCard() {
    let card = self.cardDeckGraphics.last!
    let position = CGPoint(
      x: TRIGameSceneLayout.deckPosition.x + card.size.width + 15,
      y: TRIGameSceneLayout.deckPosition.y
    )
    card.finalPosition = position
    let animation = SKAction.moveTo(
      position,
      duration: 0.2
    )
    animation.timingMode = .EaseOut
    card.runAction(animation) { () -> Void in
      card.flip()
      card.zPosition = 2000
      self.gameScene!.startGameWithCurrentCard(card)
    }
    let cardIndex = self.cardDeckGraphics.indexOf(card)
    self.cardDeckGraphics.removeAtIndex(cardIndex!)
  }
  
  private func prepareAnimatedDealing() -> [TRICard] {
    
    var animatingCards: [TRICard] = []
    
    var leftOrderedPeakRows = self.leftOrderedPeakRows
    leftOrderedPeakRows.popLast()
    
    var centerOrderedPeakRows = self.centerOrderedPeakRows
    centerOrderedPeakRows.popLast()
    
    var rightOrderedPeakRows = self.rightOrderedPeakRows
    rightOrderedPeakRows.popLast()
    
    for i in 0..<leftOrderedPeakRows.count {
      let leftRow: [TRICard] = leftOrderedPeakRows[i]
      for j in 0..<leftRow.count {
        animatingCards.append(leftRow[j])
      }
      
      let centerRow: [TRICard] = centerOrderedPeakRows[i]
      for j in 0..<centerRow.count {
        animatingCards.append(centerRow[j])
      }
      
      let rightRow: [TRICard] = rightOrderedPeakRows[i]
      for j in 0..<rightRow.count {
        animatingCards.append(rightRow[j])
      }
    }
    
    for card: TRICard in self.openCards {
      animatingCards.append(card)
    }
    
    var zpos: CGFloat = 500
    for card: TRICard in animatingCards {
      card.finalPosition = card.position
      card.position = CGPoint(
        x: TRIGameSceneLayout.deckPosition.x,
        y: TRIGameSceneLayout.deckPosition.y + 5
      )
      card.zPosition = zpos--
    }
    
    return animatingCards
    
  }
  
  private func setupCardManagers() {
    self.setupManagersForPeak(leftOrderedPeakRows)
    self.setupManagersForPeak(centerOrderedPeakRows)
    self.setupManagersForPeak(rightOrderedPeakRows)
  }
  
  private func setupManagersForPeak(peakRows: [[TRICard]]) {
    var row: Int = 0
    for currentRow: [TRICard] in peakRows {
      let isLastRow: Bool = row == peakRows.count - 1
      if !isLastRow {
        var indexOfCurrentCard: Int = 0
        for currentCard: TRICard in currentRow {
          
          let leftBlockingCard: TRICard = peakRows[row + 1][indexOfCurrentCard]
          let rightBlockingCard: TRICard = peakRows[row + 1][indexOfCurrentCard + 1]
          
          let manager = TRICardManager(
            managingCard: currentCard,
            leftBlockingCard: leftBlockingCard,
            rightBlockingCard: rightBlockingCard
          )
          
          currentCard.manager = manager
          
          indexOfCurrentCard++
          
        }
      }
      row++
    }
  }
  
  func createDeck() {
    for suit: Suit in Suit.allValues {
      for rank: Rank in Rank.allValues {
        self.cardDeck.append(
          TRICardModel(suit: suit, rank: rank)
        )
      }
    }
  }
  
  func getRandomCard() -> TRICardModel {
    let index = UInt32(self.cardDeck.count)
    let randomIndex: Int = Int(arc4random_uniform(index))
    let retVal = self.cardDeck[randomIndex]
    self.cardDeck.removeAtIndex(randomIndex)
    
    return retVal
  }
  
  func setupPeakWithTopPositionAtPoint(
    point: CGPoint) -> [TRICard] {
      let dummyCard = TRICard()
      let offset = TRIGameSceneLayout.tripeakOffsetBetweenCards
      var x: CGFloat = 0
      var y: CGFloat = 0
      
      // Top card
      x = point.x
      y = point.y - dummyCard.size.height / 2
      let topCard = self.createCard(x, y: y)
      
      // Center 2 cards
      x = topCard.position.x - topCard.size.width / 2 - offset
      y = topCard.position.y - topCard.size.height / 2
      let centerLeftCard = self.createCard(x, y: y)
      
      x = topCard.position.x + topCard.size.width / 2 + offset
      y = topCard.position.y - topCard.size.height / 2
      let centerRightCard = self.createCard(x, y: y)
      
      // Bottom 3 cards
      x = centerLeftCard.position.x - centerLeftCard.size.width / 2
      x -= offset
      y = centerLeftCard.position.y - centerLeftCard.size.height / 2
      let bottomLeftCard = self.createCard(x, y: y)
      
      x = topCard.position.x
      y = centerLeftCard.position.y - centerLeftCard.size.height / 2
      let bottomCenterCard = self.createCard(x, y: y)
      
      x = centerRightCard.position.x + centerRightCard.size.width / 2
      x += offset
      y = centerLeftCard.position.y - centerLeftCard.size.height / 2
      let bottomRightCard = self.createCard(x, y: y)
      
      return [
        topCard,
        centerLeftCard, centerRightCard,
        bottomLeftCard, bottomCenterCard, bottomRightCard
      ]
      
  }
  
  func setupTripeak() {
    let offsetY = self.gameScene!.size.height - TRIGameSceneLayout.tripeakOffsetY
    let centerX = self.gameScene!.size.width / 2
    
    let dummyCard = TRICard()
    var leftX = centerX - dummyCard.size.width * 3
    leftX -= TRIGameSceneLayout.tripeakOffsetBetweenCards * 6
    
    var rightX = centerX + dummyCard.size.width * 3
    rightX += TRIGameSceneLayout.tripeakOffsetBetweenCards * 6
    
    self.centerPeak = self.setupPeakWithTopPositionAtPoint(
      CGPoint(x: centerX, y: offsetY)
    )
    
    self.leftPeak = self.setupPeakWithTopPositionAtPoint(
      CGPoint(x: leftX, y: offsetY)
    )
    
    self.rightPeak = self.setupPeakWithTopPositionAtPoint(
      CGPoint(x: rightX, y: offsetY)
    )
    
    self.setupOpenCards()
    
  }
  
  private func splitPeaksIntoRows() {
    leftOrderedPeakRows = self.splitPeakIntoRows(self.leftPeak)
    centerOrderedPeakRows = self.splitPeakIntoRows(self.centerPeak)
    rightOrderedPeakRows = self.splitPeakIntoRows(self.rightPeak)
  }
  
  private func splitPeakIntoRows(peak: [TRICard]) -> [[TRICard]] {
    var currentRow = 0
    var cardsOnCurrentRow = 1
    var currentCardNum = 0
    // Return value
    var peakRows: [[TRICard]] = [[]]
    for card: TRICard in peak {
      
      if currentCardNum == cardsOnCurrentRow {
        peakRows.append([])
        currentCardNum = 0
        currentRow++
        cardsOnCurrentRow++
      }
      peakRows[currentRow].append(card)
      
      currentCardNum++
      
    }
    return peakRows
  }
  
  private func setupOpenCards() {
    let lastCard = self.rightPeak.last!
    
    let yPos = lastCard.position.y - lastCard.size.height / 2
    var xPos = lastCard.position.x + lastCard.size.width / 2
    
    for _ in 0...9 {
      let openCard = self.createCard(xPos, y: yPos)
      xPos -= TRIGameSceneLayout.tripeakOffsetBetweenCards * 2
      xPos -= lastCard.size.width
      self.openCards.append(openCard)
    }
    
    self.openCards = self.openCards.reverse()
    
    self.addCardsToPeak(&self.leftPeak, offset: 0)
    self.addCardsToPeak(&self.centerPeak, offset: 3)
    self.addCardsToPeak(&self.rightPeak, offset: 6)
    
    print(self.leftPeak)
    print("\n")
    print(self.centerPeak)
    print("\n")
    print(self.rightPeak)
    
  }
  
  private func addCardsToPeak(inout peak: [TRICard], offset: Int) {
    let numberOfCards = 4
    for i in offset..<offset + numberOfCards {
      let openCard = openCards[i]
      peak.append(openCard)
    }
  }
  
  private func createCard(x: CGFloat, y: CGFloat) -> TRICard {
    let card = TRICard(
      cardModel: self.getRandomCard()
    )
    card.position = CGPoint(x: x, y: y)
    self.gameScene!.addChild(card)
    
    return card
  }
  
}
