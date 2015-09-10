//
//  History.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-04-14.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import Foundation

class History {
  let beer:Beer
  let amountIn:Int
  let amountOut:Int

  static var totalIn:Int = 0
  static var totalOut:Int = 0

  init(dict:NSDictionary) {
    beer = Beer(dict:dict["beer"] as! NSDictionary)
    amountIn = dict["in"] as! Int
    amountOut = dict["out"] as! Int
  }

  class func list(completionHandler: ([History]?, NSError?) -> (Void)) {
    let manager = BeerventorySessionManager.sharedInstance
    let orgId: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("organizationId")!
    History.totalIn = 0
    History.totalOut = 0
    manager.GET("organizations/\(orgId)/history", parameters: nil, success: { (datatask, response) -> Void in
      let responseObject = response as! NSDictionary
      var histories = [History]()
      let historyObjects = responseObject["histories"] as! [NSDictionary]
      for object in historyObjects {
        let history = History(dict:object)
        histories.append(history)
        History.totalIn += history.amountIn
        History.totalOut += history.amountOut
      }
      completionHandler(histories, nil)

      }) { (datatask, error) -> Void in
        println("error: \(error)")
        completionHandler(nil, error)
    }
  }
}

