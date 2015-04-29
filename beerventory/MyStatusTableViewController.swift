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

  var histories = [History]()

  override func viewDidLoad() {
    History.list { (history, error) -> (Void) in
      self.histories = history!
      self.totalInLabel.text = "+\(History.totalIn)"
      self.totalOutLabel.text = "-\(History.totalOut)"
      self.tableView.reloadData()
    }
//TODO hantera error
  }

  
  @IBAction func done(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let history = histories[indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("historyCell") as! HistoryBeerCell
    cell.beerLabel.attributedText = history.beer.attributedName(false)
    if history.amountIn > 0 {
      cell.inLabel.text = "+\(history.amountIn)"
    } else {
      cell.inLabel.text = ""
    }
    if history.amountOut > 0 {
      cell.outLabel.text = "-\(history.amountOut)"
    } else {
      cell.outLabel.text = ""
    }

    return cell
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return histories.count
  }
}

