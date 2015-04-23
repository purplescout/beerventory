//
//  Inventory.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-04-23.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import Foundation

class Inventory {
  let beer:Beer
  let amount:Int

  init(dict:NSDictionary) {
    beer = Beer(dict:dict["beer"] as! NSDictionary)
    amount = dict["amount"] as! Int
  }

  class func list(completionHandler: ([Inventory]?, NSError?) -> (Void)) {
    let manager = BeerventorySessionManager.sharedInstance
    //TODO correct id
    manager.GET("organization/id/inventory", parameters: nil, success: { (datatask, response) -> Void in
      let responseObject = response as! NSDictionary
      var inventories = [Inventory]()
      let inventoryObjects = responseObject["inventories"] as! [NSDictionary]
      for object in inventoryObjects {
        let inventory = Inventory(dict:object)
        inventories.append(inventory)
      }
      completionHandler(inventories, nil)

      }) { (datatask, error) -> Void in
        println("error: \(error)")
        completionHandler(nil, error)
    }
  }

  class func update(inventoryDiff: [Beer], completionHandler: (NSError?) -> (Void)) {
    var dict = Dictionary<String, Array<Dictionary<String, String>>>()
    dict["beers"] = [Dictionary]()
    for beer in inventoryDiff {
      var beerDict = Dictionary<String, String>()
      beerDict["id"] = String(beer.id)
      beerDict["amount"] = String(beer.amount)
      dict["beers"]!.append(beerDict)
    }
    let manager = BeerventorySessionManager.sharedInstance
    //TODO correct id
    manager.GET("organization/id/inventory", parameters: dict, success: { (datatask, response) -> Void in
      completionHandler(nil)
      }) { (datatask, error) -> Void in
        println("error: \(error)")
        completionHandler(error)
    }

  }
}
