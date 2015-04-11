//
//  InsertBeerCell.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-03-31.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import UIKit


class InsertBeerCell: UITableViewCell {

  var controller:InsertViewController!
  var beerId:Int!

  @IBOutlet weak var beerLabel: UILabel!
  @IBOutlet weak var numberOfBeersLabel: UILabel!

  @IBAction func minus(sender: AnyObject) {
    controller.changeBeerAmount(beerId, add:-1)
  }
  @IBAction func plus(sender: AnyObject) {
    controller.changeBeerAmount(beerId, add:1)
  }
}