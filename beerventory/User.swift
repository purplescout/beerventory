//
//  User.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-02-23.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import Foundation

class User {
  class func login(email: String, password: String, completionHandler: (AnyObject?, NSError?) -> (Void)) {
    let manager = BeerventorySessionManager.sharedInstance
    let params = ["email":email, "password":password]
    manager.POST("session", parameters: params, success: { (datatask, response) -> Void in
      println("response: \(response)")
      let responseObject = response as NSDictionary
      let userObject = responseObject["user"] as NSDictionary

      NSUserDefaults.standardUserDefaults().setObject(userObject["id"], forKey: "userId")
      NSUserDefaults.standardUserDefaults().setObject(userObject["api_token"], forKey: "apiToken")
      completionHandler(response, nil)
    }) { (datatask, error) -> Void in
      println("error: \(error)")
      completionHandler(nil, error)
    }
  }
}
