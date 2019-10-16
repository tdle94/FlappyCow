//
//  Timer.swift
//  FlutterCow
//
//  Created by Aromajoin on 2019/10/16.
//  Copyright © 2019 Tuyen Le. All rights reserved.
//

import Foundation

struct Timer {
  private(set) var previousUpdateTime: TimeInterval = TimeInterval(exactly: 0) ?? 0
  
  private(set) var timeSinceLastUpdate: TimeInterval = TimeInterval(exactly: 0) ?? 0
  
  private(set) var timeSinceFirstUpdate: TimeInterval = TimeInterval(exactly: 0) ?? 0
  
  var firstUpdate: Bool = false
  
  mutating func updateTimer(currentTime: TimeInterval) {
    if firstUpdate {
      previousUpdateTime = currentTime
      firstUpdate = false
    }
    
    timeSinceLastUpdate = currentTime - previousUpdateTime
    timeSinceFirstUpdate += timeSinceLastUpdate
    previousUpdateTime = currentTime

  }
}
