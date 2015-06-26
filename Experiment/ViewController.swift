//
//  ViewController.swift
//  Experiment
//
//  Created by Steven Hertz on 6/10/15.
//  Copyright (c) 2015 Steven Hertz. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  
  let appDelg = UIApplication.sharedApplication().delegate as! AppDelegate
  var image = UIImage()
  var myMeMe : MeMe!
  var memImage = UIImage()
  let memeTextAttributes = [
    NSStrokeColorAttributeName : UIColor.cyanColor(),
    NSForegroundColorAttributeName : UIColor.brownColor(),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
    NSStrokeWidthAttributeName : NSNumber(float: -3.0)
  ]
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var topText: UITextField!
  @IBOutlet weak var bottomText: UITextField!
  @IBOutlet weak var toolBar: UIToolbar!
  @IBOutlet weak var cameraBarButton: UIBarButtonItem!
  
  //* Button Actions

    @IBAction func cancel(sender: AnyObject) {
      if let navigationController = navigationController {
        navigationController.popViewControllerAnimated(true)    }
    }
    

    @IBAction func useCamera(sender: AnyObject) {

        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.mediaTypes = [kUTTypeImage as NSString]
        imagePicker.allowsEditing = false
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }

      @IBAction func useLibrary(sender: AnyObject) {

        // Verifications:  verify that there is a photo library
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as NSString]
        imagePicker.allowsEditing = false
        
        presentViewController(imagePicker, animated: true, completion: nil)
      }
  }
      
  
  //* Image picker control delegate methods
  
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
      dismissViewControllerAnimated(true, completion: nil)
      let mediaType = info[UIImagePickerControllerMediaType] as! NSString
      if mediaType.isEqualToString(kUTTypeImage as! String) {
        image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image }
        //println("picked something")

      myMeMe = MeMe(topText: topText.text, bottomText: bottomText.text, image: imageView.image!,memImage: memImage )
      navigationItem.leftBarButtonItem!.enabled = true;
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
      dismissViewControllerAnimated(true, completion: nil)
      //println("did cancel")
    }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    cameraBarButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    topText.text = "TOP"
    topText.defaultTextAttributes = memeTextAttributes
    topText.textAlignment = .Center
    bottomText.text = "BOTTOM"
    bottomText.defaultTextAttributes = memeTextAttributes
    bottomText.textAlignment = .Center

    topText.delegate = self
    bottomText.delegate = self
    
    if appDelg.myMeMeArray.count < 1 {
      navigationItem.rightBarButtonItem!.enabled = false }
    
      navigationItem.leftBarButtonItem!.enabled = false

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  
  @IBAction func activityView () {
    let nextViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    presentViewController(nextViewController, animated: true) { (self.appDelg).myMeMeArray.append(MeMe(topText: self.topText.text, bottomText: self.bottomText.text, image: self.imageView.image!, memImage: self.generateMemedImage() )) ;      self.navigationItem.rightBarButtonItem!.enabled = true }
  }
  
  func generateMemedImage() -> UIImage {
    
    toolBar.hidden = true
    
    // Render view to an image
    UIGraphicsBeginImageContext(view.frame.size)
    view.drawViewHierarchyInRect(view.frame,afterScreenUpdates: true)
    let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    toolBar.hidden = false
    
    return memedImage
  }
  
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
  
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    tabBarController?.tabBar.hidden = true
    subscribeToKeyboardNotifications()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(true)
    tabBarController?.tabBar.hidden = false
    unsubscribeFromKeyboardNotifications()
  }
  
  
  func subscribeToKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  
  
  func keyboardWillShow(notification: NSNotification) {
    //println("in keyboardWillShow")
    if bottomText.isFirstResponder() {
    view.frame.origin.y -= getKeyboardHeight(notification)
    //println("doing bottom - moving the screen") 
    }
  }
  
  
  func keyboardWillHide(notification: NSNotification) {
    //println("in keyboardWillHide")

    if view.frame.origin.y != 0{
    view.frame.origin.y += getKeyboardHeight(notification)
      //println(" doing bottom - putting screen back") 
    }
  }
  
  
  func getKeyboardHeight(notification: NSNotification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
    return keyboardSize.CGRectValue().height
  }
}
