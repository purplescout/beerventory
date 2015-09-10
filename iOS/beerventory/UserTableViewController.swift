//
//  UserTableViewController.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-03-15.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController, UITableViewDataSource {

  var users = [User]()

  @IBAction func done(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }

  override func viewDidLoad() {
    User.list { (users, error) -> (Void) in
      self.users = users!
      self.tableView.reloadData()
    }
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let user = users[indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("userCell") as! UserCell

    cell.label.text = user.name
    if user.beerAmount > 0 {
      cell.noLabel.text = "+\(user.beerAmount)"
    } else if user.beerAmount < 0 {
      cell.noLabel.text = "-\(user.beerAmount)"
    } else {
      cell.noLabel.text = "0"
    }
    return cell
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
}


