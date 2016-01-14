//
//  TRISoundManager.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/14/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import Foundation

class TRISoundManager: NSObject {

  static var instance: TRISoundManager = TRISoundManager()
  let manager = OALSimpleAudio.sharedInstance()
  
  override init() {
    super.init()
  }
  
  func playSound(sound: TRISounds) {
    manager.playEffect(sound.rawValue)
  }
  
  func preloadSounds() {
    for sound in TRISounds.allValues {
      manager.preloadEffect(sound.rawValue)
    }
  }
  
}
