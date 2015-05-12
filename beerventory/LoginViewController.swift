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
  @IBOutlet weak var forgotPasswordButton: UIButton!
  @IBOutlet weak var switchModeButton: UIButton!

  var signUpMode:Bool = true

  @IBAction func forgotPassword(sender: AnyObject) {
  }
  
  @IBAction func switchMode(sender: AnyObject) {
    signUpMode = !signUpMode
    nameTextField.hidden = !signUpMode
    invitationCodeTextField.hidden = !signUpMode
    forgotPasswordButton.hidden = signUpMode
    switchModeButton.setTitle(signUpMode ? "Already have an account? Sign in" : "Have an invitation code? Sign up", forState: .Normal)
    passwordTextField.returnKeyType = signUpMode ? .Next : .Send
  }

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if textField == emailTextField {
      passwordTextField.becomeFirstResponder()
    } else if textField == passwordTextField {
      if signUpMode {
        nameTextField.becomeFirstResponder()
      } else { //login
        if emailTextField.text.isEmpty {
          emailTextField.becomeFirstResponder()
        } else if passwordTextField.text.isEmpty {
          passwordTextField.becomeFirstResponder()
        } else {
          User.login(emailTextField.text, password: passwordTextField.text) { response,error in
            self.dismissViewControllerAnimated(true, completion: nil)
            //TODO handle error
          }
        }
      }
    } else if (textField == nameTextField) {
      invitationCodeTextField.becomeFirstResponder()
    } else if (textField == invitationCodeTextField) {
      if emailTextField.text.isEmpty {
        emailTextField.becomeFirstResponder()
      } else if passwordTextField.text.isEmpty {
        passwordTextField.becomeFirstResponder()
      } else if nameTextField.text.isEmpty {
        nameTextField.becomeFirstResponder()
      } else if invitationCodeTextField.text.isEmpty {
        invitationCodeTextField.becomeFirstResponder()
      } else {
        User.signup(emailTextField.text, password: passwordTextField.text, name: nameTextField.text, invitationCode: invitationCodeTextField.text, completionHandler: { (result, error) -> (Void) in
          self.dismissViewControllerAnimated(true, completion: nil)
        })
        //TODO handle error
      }
    }
    return true
  }

  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    view.endEditing(true)
  }
}