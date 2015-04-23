//
//  TakeOutViewController.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-03-28.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import Foundation


class TakeOutViewController: UIViewController {

  @IBOutlet weak var scanView: UIView!
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var beerLabel: UILabel!
  @IBOutlet weak var okButton: UIButton!

  var scanner: BeerScanner?
  var beer: Beer?


  @IBAction func cancel(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  @IBAction func ok(sender: AnyObject) {
    beer!.amount = -1
    Inventory.update([beer!], completionHandler: { (error) -> (Void) in
      //TODO handle error
      self.dismissViewControllerAnimated(true, completion: nil)
    })
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.scanner = BeerScanner(scanView: scanView, callback: findBeer)
    scanner?.startStopReading()
  }

  func findBeer(ean: String) {
    //alse check if beer in fridge
    Beer.find(ean, completionHandler: { (beer, error) -> (Void) in
      if beer == nil {
        //beer not in system
      } else {

        self.beer = beer!
        self.messageLabel.text = "Enjoy your"
        self.beerLabel.attributedText = beer!.attributedName(false)
        self.okButton.titleLabel?.text = "I will!"
      }
    })
  }
}