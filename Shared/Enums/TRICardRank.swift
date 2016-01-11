//
//  TRICardRank.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/11/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import Foundation

enum Rank: Int {
  case Ace = 1
  case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
  case Jack, Queen, King
  func stringValue() -> String {
    switch self {
    case .Ace:
      return "A"
    case .Jack:
      return "J"
    case .Queen:
      return "Q"
    case .King:
      return "K"
    default:
      return String(self.rawValue)
    }
  }
  static let allValues = [
    Rank.Two,
    Rank.Three,
    Rank.Four,
    Rank.Five,
    Rank.Six,
    Rank.Seven,
    Rank.Eight,
    Rank.Nine,
    Rank.Ten,
    Rank.Jack,
    Rank.Queen,
    Rank.King,
    Rank.Ace
  ]
}
