//
//  SwitchOrganizationViewController.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-05-05.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import Foundation

class SwitchOrganizationViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

  @IBAction func cancel(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }

  var organizations = [Organization]()

  override func viewDidLoad() {
    Organization.list { (organizations, error) -> (Void) in
      self.organizations = organizations!
      self.tableView.reloadData()
    }
    //TODO hantera error
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let currentOrgId: NSNumber = NSUserDefaults.standardUserDefaults().objectForKey("organizationId")! as! NSNumber
    let organization = organizations[indexPath.row]
    let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("organizationCell")! as! UITableViewCell
    cell.textLabel!.text = organization.name
    if organization.id == currentOrgId {
      cell.accessoryType = UITableViewCellAccessoryType.Checkmark
    } else {
      cell.accessoryType = UITableViewCellAccessoryType.None
    }
    return cell
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return organizations.count
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let organization = organizations[indexPath.row]
    NSUserDefaults.standardUserDefaults().setInteger(organization.id, forKey: "organizationId")
    NSUserDefaults.standardUserDefaults().setObject(organization.name, forKey: "organizationName")
    NSUserDefaults.standardUserDefaults().synchronize()
    dismissViewControllerAnimated(true, completion: nil)
  }

}

