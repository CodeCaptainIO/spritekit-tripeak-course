//
//  TRICardModel.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/11/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import Foundation

class TRICardModel: NSObject {

  var suit: Suit
  var rank: Rank
  var asset: String {
    get {
      return "card" + suit.rawValue + rank.stringValue()
    }
  }
  
  init(suit: Suit, rank: Rank) {
    self.rank = rank
    self.suit = suit
    super.init()
  }
  
}
