//
//  BeerventorySessionManager.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-02-23.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import Foundation

class BeerventorySessionManager: AFHTTPSessionManager {
  class var sharedInstance: BeerventorySessionManager {
    struct Static {
      static let instance: BeerventorySessionManager = BeerventorySessionManager(baseURL: NSURL(string: "http://guarded-ravine-1984.herokuapp.com"))
    }
    Static.instance.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
    return Static.instance
  }
}