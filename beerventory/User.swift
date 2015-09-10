//
//  User.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-02-23.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import Foundation

class User {
  let id:Int
  let name:String
  let email:String
  let beerAmount:Int

  init(dict:NSDictionary) {
    id = dict["id"] as! Int
    name = dict["name"] as! String
    email = dict["email"] as! String
    beerAmount = dict["beer_amount"] as! Int
  }

  class func login(email: String, password: String, completionHandler: (AnyObject?, NSError?) -> (Void)) {
    let manager = BeerventorySessionManager.sharedInstance
    let params = ["email":email, "password":password]
    manager.POST("session", parameters: params, success: { (datatask, response) -> Void in
      println("response: \(response)")
      let responseObject = response as! NSDictionary
      let userObject = responseObject["user"] as! NSDictionary

      NSUserDefaults.standardUserDefaults().setObject(userObject["id"], forKey: "userId")
      NSUserDefaults.standardUserDefaults().setObject(userObject["name"], forKey: "userName")
      NSUserDefaults.standardUserDefaults().setObject(userObject["api_token"], forKey: "apiToken")
      let organizations = userObject["organizations"] as! NSArray
      NSUserDefaults.standardUserDefaults().setObject(organizations[0]["id"], forKey: "organizationId")
      NSUserDefaults.standardUserDefaults().setObject(organizations[0]["name"], forKey: "organizationName")
      completionHandler(response, nil)
    }) { (datatask, error) -> Void in
      println("error: \(error)")
      completionHandler(nil, error)
    }
  }

  class func list(completionHandler: ([User]?, NSError?) -> (Void)) {
    let manager = BeerventorySessionManager.sharedInstance
    let orgId: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("organizationId")!
    manager.GET("organizations/\(orgId)/users", parameters: nil, success: { (datatask, response) -> Void in
      let responseObject = response as! NSDictionary
      var users = [User]()
      let userObjects = responseObject["users"] as! [NSDictionary]
      for object in userObjects {
        let user = User(dict:object)
        users.append(user)
      }
      completionHandler(users, nil)

      }) { (datatask, error) -> Void in
        println("error: \(error)")
        completionHandler(nil, error)
    }
  }
}
