//
//  LoginViewController.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-01-27.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var invitationCodeTextField: UITextField!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var forgotPasswordButton: UIButton!

  @IBAction func switchMode(sender: AnyObject) {
    let isSignIn = segmentedControl.selectedSegmentIndex == 0
    nameTextField.hidden = !isSignIn
    invitationCodeTextField.hidden = !isSignIn
    forgotPasswordButton.hidden = isSignIn
  }

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if (textField == emailTextField) {
      passwordTextField.becomeFirstResponder()
    } else if (textField == passwordTextField) {
      if (segmentedControl.selectedSegmentIndex == 0) {
        nameTextField.becomeFirstResponder()
      }else {
        //login
      }
    } else if (textField == nameTextField) {
      invitationCodeTextField.becomeFirstResponder()
    } else if (textField == invitationCodeTextField) {
      //signup
      dismissViewControllerAnimated(true, completion: nil)
    }
    return true
  }

  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    view.endEditing(true)
  }

}