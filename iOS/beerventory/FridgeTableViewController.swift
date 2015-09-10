//
//  FridgeTableViewController.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-03-15.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.


import UIKit

class FridgeTableViewController: UITableViewController, UITableViewDataSource {

  var inventories = [Inventory]()

  override func viewDidLoad() {
    Inventory.list { (inventories, error) -> (Void) in
      self.inventories = inventories!
      self.tableView.reloadData()
    }
  }

  @IBAction func done(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let inventory = inventories[indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("beerCell") as! FridgeBeerCell

    cell.label.attributedText = inventory.attributedName()
    return cell
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return inventories.count
  }
}

