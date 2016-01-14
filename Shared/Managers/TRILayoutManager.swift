//
//  TRILayoutManager.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/14/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import Foundation

class TRILayoutManager: NSObject {

  class func setupGameLayout() {
    
    var layout: TRIBaseGameLayoutDevice = .IPhone6
    
    if DeviceType.IS_IPAD {
      layout = .IPad
    } else {
      if DeviceType.IS_IPHONE_6 {
        layout = .IPhone6
      } else if DeviceType.IS_IPHONE_6P {
        layout = .IPhone6p
      } else if DeviceType.IS_IPHONE_5 {
        layout = .IPhone5
      } else if DeviceType.IS_IPHONE_4_OR_LESS {
        layout = .IPhone4OrLess
      }
    }
    
    TRILayoutManager.setup(layout)
    
  }
  
  class func setup(layout: TRIBaseGameLayoutDevice) {
    TRIGameSceneLayout.setup(layout)
    TRIOverlayLayout.setup(layout)
    TRIMenuSceneLayout.setup(layout)
  }
  
}
