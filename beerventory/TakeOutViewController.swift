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


  @IBAction func cancel(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  @IBAction func ok(sender: AnyObject) {
    //TODO save
    dismissViewControllerAnimated(true, completion: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.scanner = BeerScanner(scanView: scanView, callback: findBeer)
    scanner?.startStopReading()
  }

  func findBeer(ean: String) {
    //if found beer
    messageLabel.text = "Enjoy your"
    beerLabel.text = ean
    okButton.titleLabel?.text = "I will!"
    //else
    //okButton.titleLabel?.text = "Ok"

  }
}