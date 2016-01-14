//
//  TRIGameSceneLayout.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/11/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import Foundation

class TRIGameSceneLayout: NSObject {

  static var timerHeight: CGFloat = 5.0
  static var hudHeight: CGFloat = 40.0
  static var hudFont: String = Fonts.HelveticaNeueLight.rawValue
  static var hudFontSize: CGFloat = 21.0
  static var openCardOffset: CGFloat = 10.0
  static var deckPosition: CGPoint = CGPoint(x: 40, y: 50)
  static var tripeakOffsetY: CGFloat = 60.0
  static var tripeakOffsetBetweenCards: CGFloat = 2.0
  static var cardSizeMultiplier = 0.75
  static var cardSize: CGSize = CGSize(
    width: 77 * cardSizeMultiplier,
    height: 104 * cardSizeMultiplier
  )
  
}
