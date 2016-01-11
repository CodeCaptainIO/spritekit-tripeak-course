//
//  TRIGameSceneLayout.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/11/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import Foundation

class TRIGameSceneLayout: NSObject {

  static var tripeakOffsetY: CGFloat = 80.0
  static var tripeakOffsetBetweenCards: CGFloat = 2.0
  static var cardSizeMultiplier = 0.75
  static var cardSize: CGSize = CGSize(
    width: 77 * cardSizeMultiplier,
    height: 104 * cardSizeMultiplier
  )
  
}
