//
//  TRIBack.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/11/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import Foundation

enum CardBackColor: String {
  case Blue
  case Green
  case Red
  func stringValue() -> String {
    return self.rawValue.lowercaseString
  }
}

enum CardBackType: Int {
  case Type1 = 1
  case Type2
  case Type3
  case Type4
  case Type5
  func stringValue() -> String {
    return String(self.rawValue)
  }
}
