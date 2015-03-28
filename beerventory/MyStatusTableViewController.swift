//
//  MyStatusTableViewController.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-03-28.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import UIKit

class MyStatusTableViewController: UITableViewController, UITableViewDataSource {

  @IBOutlet weak var totalInLabel: UILabel!
  @IBOutlet weak var totalOutLabel: UILabel!

  
  @IBAction func done(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
 override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("historyCell") as HistoryBeerCell
    cell.beerLabel.text = "Staropramen"
    cell.inLabel.text = "+10"
    cell.outLabel.text = "-10"
    return cell
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
}

