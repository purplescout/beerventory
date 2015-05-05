//
//  Organization.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-05-05.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import Foundation

class Organization {
  let id:Int
  let name:String

  init(dict:NSDictionary) {
    id = dict["id"] as! Int
    name = dict["name"] as! String
  }

  class func list(completionHandler: ([Organization]?, NSError?) -> (Void)) {
    let manager = BeerventorySessionManager.sharedInstance
    manager.GET("users/me", parameters: nil, success: { (datatask, response) -> Void in
      let responseObject = response as! NSDictionary
      var organizations = [Organization]()
      let userObject = responseObject["user"] as! NSDictionary
      let organizationObjects = userObject["organizations"] as! [NSDictionary]
      for object in organizationObjects {
        let organization = Organization(dict:object)
        organizations.append(organization)
      }
      completionHandler(organizations, nil)

      }) { (datatask, error) -> Void in
        println("error: \(error)")
        completionHandler(nil, error)
    }
  }
}
