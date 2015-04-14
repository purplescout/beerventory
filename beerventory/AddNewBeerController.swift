//
//  AddNewBeerController.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-04-11.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import UIKit

class AddNewBeerController: UIViewController, UITextFieldDelegate {

  var delegate:InsertViewController!
  var ean:String!

  @IBOutlet weak var beerNameField: UITextField!
  @IBOutlet weak var volumeField: UITextField!
  @IBAction func cancel(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if textField == beerNameField {
      volumeField.becomeFirstResponder()
    } else if textField == volumeField {
      view.endEditing(true)
      addIt(self)
    }
    return true
  }

  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    view.endEditing(true)
  }

  @IBAction func addIt(sender: AnyObject) {
    if beerNameField.text.isEmpty {
      beerNameField.becomeFirstResponder()
    } else if volumeField.text.isEmpty || volumeField.text.toInt() == nil {
      volumeField.becomeFirstResponder()
    } else {
      let vol = Float(volumeField.text.toInt()!) / 1000
      Beer.save(ean, name:beerNameField.text, volume:vol, completionHandler: { (beer, error) -> (Void) in
        if error == nil {
          self.delegate!.addNewBeer(beer!)
          self.dismissViewControllerAnimated(true, completion: nil)
        } else {
          let alert = UIAlertView(title: "Sorry, couldn't save that", message: "please try again", delegate: nil, cancelButtonTitle: "ok")
          alert.show()
        }
      })
    }
  }

}

