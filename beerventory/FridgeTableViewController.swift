//
//  FridgeTableViewController.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-03-15.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.


import UIKit

class FridgeTableViewController: UITableViewController, UITableViewDataSource {

  @IBAction func done(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("beerCell") as FridgeBeerCell
    cell.label.text = "1st Mythos"
    return cell
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
}

