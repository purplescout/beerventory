//
//  InsertViewController.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-03-31.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import UIKit

class InsertViewController: UITableViewController, UITableViewDataSource {

  var beers = [Beer]()
  var scanner: BeerScanner?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let scanView = UIView(frame: self.tableView.bounds)
    scanView.userInteractionEnabled = false
    self.tableView.addSubview(scanView)
    self.scanner = BeerScanner(scanView: scanView, callback: findBeer)
    scanner?.startStopReading()
  }

  @IBAction func cancel(sender: AnyObject) {
    if scanner != nil && scanner!.isReading {
      scanner?.startStopReading()
    } else {
      dismissViewControllerAnimated(true, completion: nil)
    }
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let beer = beers[indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("insertBeerCell") as! InsertBeerCell
    cell.controller = self
    cell.beerId = beer.id
    cell.beerLabel.text = beer.name
    let amount = beer.amount
    cell.numberOfBeersLabel.text = "\(amount)"
    return cell
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return beers.count
  }

  func findBeer(ean: String) {
    Beer.find(ean, completionHandler: { (beer, error) -> (Void) in
      if beer == nil {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("addNewBeerController") as! UINavigationController
        let addNewBeerController = vc.topViewController as! AddNewBeerController
        addNewBeerController.delegate = self
        addNewBeerController.ean = ean
        self.presentViewController(vc, animated: true, completion: nil)
      } else {
        let scannedBefore = filter(self.beers) { (b) in b.id == beer!.id }.count > 0
        if scannedBefore {
          self.changeBeerAmount(beer!.id, add: 1)
          self.tableView.reloadData()
        } else {
          self.addNewBeer(beer!)
        }
      }
    })
  }

  func addNewBeer(beer:Beer) {
    beer.amount = 1
    beers.append(beer)
    self.tableView.reloadData()
  }

  func changeBeerAmount(id:Int, add:Int) {
    for index in 0...beers.count {
      var beer = beers[index]
      if (beer.id == id) {
        var amount = beer.amount + add
        if amount < 0 {
          amount = 0
        }
        beer.amount = amount
        beers[index] = beer
        break
      }
    }
    self.tableView.reloadData()
  }

  @IBAction func scanMore(sender: AnyObject) {
    scanner?.startStopReading()
  }

  @IBAction func sendBeers(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }

}