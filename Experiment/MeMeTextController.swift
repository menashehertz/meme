//
//  MeMeTextController.swift
//  Experiment
//
//  Created by Steven Hertz on 6/11/15.
//  Copyright (c) 2015 Steven Hertz. All rights reserved.
//

import Foundation
import UIKit


class MeMeTextController: NSObject, UITextFieldDelegate {
  
  // Text Field Delegate Methods
  
  
  func textFieldDidBeginEditing(textField: UITextField) {
    if textField.text == "TOP" {
      textField.text = ""
    }
    if textField.text == "BOTTOM" {
      textField.text = ""
    }
 }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if textField.text == "" {
      textField.text = "TOP"
    }

    textField.resignFirstResponder()
    
    return true;
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
    // verify that the string ia a numeral
    switch string {
    case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
      println("it is a number")
    default:
      return false
    }
    
    // Verify it isn' more than 5 chars
    var newText: NSString = textField.text
    newText = newText.stringByReplacingCharactersInRange(range, withString: string)
    
    // Return false if it is more than 5 chars
    if newText.length > 5 { return false } else { return true } ;
    
  }
  
}
