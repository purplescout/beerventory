//
//  Beer.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-04-11.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import Foundation

class Beer {
  let id:Int
  let name:String
  let volume:Float
  var amount:Int

  init(dict:NSDictionary) {
    id = dict["id"] as! Int
    name = dict["name"] as! String
    volume = (dict["volume"] as! NSString).floatValue
    amount = 0
  }

  class func find(ean:String, completionHandler: (Beer?, NSError?) -> (Void)) {
    let manager = BeerventorySessionManager.sharedInstance
    manager.GET("beers/\(ean)", parameters: nil, success: { (datatask, response) -> Void in
      let responseObject = response as! NSDictionary
      let beerObject = responseObject["beer"] as! NSDictionary
      let beer = Beer(dict: beerObject)
      completionHandler(beer, nil)

      }) { (datatask, error) -> Void in
        println("error: \(error)")
        completionHandler(nil, error)
    }
  }

  class func save(ean:String, name:String, volume:Float, completionHandler: (Beer?, NSError?) -> (Void)) {
    let manager = BeerventorySessionManager.sharedInstance
    let params = ["beer[barcode]":ean, "beer[name]":name, "beer[volume]":volume]
    manager.POST("beers", parameters: params, success: { (datatask, response) -> Void in
      let responseObject = response as! NSDictionary
      let beerObject = responseObject["beer"] as! NSDictionary
      let beer = Beer(dict: beerObject)
      completionHandler(beer, nil)

      }) { (datatask, error) -> Void in
        println("error: \(error)")
        completionHandler(nil, error)
    }
  }
}