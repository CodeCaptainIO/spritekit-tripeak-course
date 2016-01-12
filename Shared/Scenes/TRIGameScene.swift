//
//  GameScene.swift
//  Tripeak_iOS
//
//  Created by CodeCaptain on 12/30/15.
//  Copyright (c) 2015 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIGameScene: SKScene {
  
  private var gameSetupManager: TRIGameSetupManager?
  private var gameFlowManager: TRIGameFlowManager?
  var leftPeak: [TRICard] = []
  var centerPeak: [TRICard] = []
  var rightPeak: [TRICard] = []
  var cardDeckGraphics: [TRICard] = []
  weak var currentCard: TRICard?
  var state: TRIGameState = .WillStart
  
  override func didMoveToView(view: SKView) {
    
    TRIHighscoreManager.instance.reset()
    
    let gameSetupManager = TRIGameSetupManager(
      gameScene: self
    )
    self.gameSetupManager = gameSetupManager
    self.gameSetupManager!.setup()
    
    self.gameFlowManager = TRIGameFlowManager(
      gameScene: self
    )
    
    self.setupInterface()
    
  }
  
  private func setupInterface() {
    
    let hudBG = SKSpriteNode(
      color: SKColor.blackColor().colorWithAlphaComponent(0.2),
      size: CGSize(
        width: self.size.width,
        height: TRIGameSceneLayout.hudHeight
      )
    )
    hudBG.position = CGPoint(
      x: self.size.width / 2,
      y: self.size.height - hudBG.size.height / 2
    )
    self.addChild(hudBG)
    
    let highscoreElement = TRIHighscoreElement()
    highscoreElement.position = hudBG.position
    TRIHighscoreManager.instance.addSubscriber(highscoreElement)
    self.addChild(highscoreElement)
    
  }
  
  func startGameWithCurrentCard(card: TRICard) {
    self.currentCard = card
    self.state = .Started
  }
  
  func gameOver() {
    print("Game Over")
    self.backgroundColor = SKColor.purpleColor()
    state = .Ended
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let touch = touches.first
    let point = touch!.locationInNode(self)
    if state == .Started {
      self.gameFlowManager!.handleTouchStart(point)
      return
    }
    if state == .Ended {
      let gameScene = TRIGameScene(size: self.size)
      self.view?.presentScene(
        gameScene,
        transition: SKTransition.fadeWithDuration(1.0)
      )
      return
    }
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    #if DEBUG
      self.touchesBegan(touches, withEvent: event)
    #endif
  }
  
}
