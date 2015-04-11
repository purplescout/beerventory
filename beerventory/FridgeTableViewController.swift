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
    let cell = tableView.dequeueReusableCellWithIdentifier("beerCell") as! FridgeBeerCell
    var attrBeer = [NSFontAttributeName : UIFont(name: "ArialRoundedMTBold", size: 20.0)!]
    var beerString = NSMutableAttributedString(string:"1 st Mythos", attributes:attrBeer)
    var attrVolume = [NSFontAttributeName : UIFont(name: "ArialRoundedMTBold", size: 14.0)!]
    var volumeString = NSMutableAttributedString(string:" (33cl)", attributes:attrVolume)

    beerString.appendAttributedString(volumeString)

    cell.label.attributedText = beerString
    return cell
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
}

