//
//  ViewController.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-01-18.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var organizationLabel: UILabel!
  @IBOutlet weak var myStatusLabel: UILabel!
  @IBOutlet weak var fridgeStatusLabel: UILabel!
  @IBOutlet weak var allUserStatusLabel: UILabel!
  @IBOutlet weak var takeOutButtonLabel: UILabel!
  @IBOutlet weak var insertButtonLabel: UILabel!

  @IBAction func showMyStatus(sender: AnyObject) {
  }

  @IBAction func showFridgeStatus(sender: AnyObject) {
  }

  @IBAction func showAllUserStatus(sender: AnyObject) {
  }

  @IBAction func showTakeOut(sender: AnyObject) {
  }

  @IBAction func showInsert(sender: AnyObject) {
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

