//
//  ViewController.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-01-18.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIActionSheetDelegate {
  @IBOutlet weak var myStatusLabel: UILabel!
  @IBOutlet weak var fridgeStatusLabel: UILabel!
  @IBOutlet weak var allUserStatusLabel: UILabel!
  @IBOutlet weak var takeOutButtonLabel: UILabel!
  @IBOutlet weak var insertButtonLabel: UILabel!
  @IBOutlet weak var nameButton: UIButton!
  @IBOutlet weak var organizationButton: UIButton!


  @IBAction func showUserOptions(sender: AnyObject) {
    let sheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: "Log out")
    sheet.showInView(self.view)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
    if buttonIndex == actionSheet.destructiveButtonIndex {
      User.logout()
      presentLoginIfNeeded()
    }
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    presentLoginIfNeeded()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func presentLoginIfNeeded() {
    if (NSUserDefaults.standardUserDefaults().objectForKey("userId") == nil) {
      if let loginViewController: UIViewController = storyboard?.instantiateViewControllerWithIdentifier("loginViewController") as? UIViewController {
        presentViewController(loginViewController, animated: false, completion: nil)
      }
    } else {
      organizationButton.setTitle(NSUserDefaults.standardUserDefaults().objectForKey("organizationName") as? String, forState: .Normal)
      nameButton.setTitle(NSUserDefaults.standardUserDefaults().objectForKey("userName") as? String, forState: .Normal)
    }
  }


}

