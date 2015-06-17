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
  
  let memeTextAttributes = [
    NSStrokeColorAttributeName : UIColor.blueColor(),
    NSForegroundColorAttributeName : UIColor.brownColor(),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)!
    //NSStrokeWidthAttributeName : //TODO: Fill in appropriate Float
  ]
  
  var image = UIImage()
  
  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var topText: UITextField!
  
  @IBOutlet weak var bottomText: UITextField!
  
  @IBOutlet weak var toolBar: UIToolbar!
  
  var myMeMe : MeMe!
  
  var memImage = UIImage()
  
  var myMeMeArray : [MeMe] = []
  
  
  
  //* Button Actions
  
  @IBAction func useCamera(sender: AnyObject) {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
      
      let imagePicker = UIImagePickerController()
      
      imagePicker.delegate = self
      imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
      imagePicker.mediaTypes = [kUTTypeImage as NSString]
      imagePicker.allowsEditing = false
      
      self.presentViewController(imagePicker, animated: true, completion: nil)
    }
  }

      @IBAction func useLibrary(sender: AnyObject) {
      if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as NSString]
        imagePicker.allowsEditing = false
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
      }
  }
      
    @IBAction func launchImagePicker() {
      // Verifications:  verify that there is a photo library
      if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
        println("camera is not available")
        return
      }
      // Launch the Image picker Controller
      let myController = UIImagePickerController()
      myController.delegate = self
      self.presentViewController(myController, animated: true, completion: nil)
  }
  
  
  //* Image picker control delegate methods
  
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
      self.dismissViewControllerAnimated(true, completion: nil)
      let mediaType = info[UIImagePickerControllerMediaType] as! NSString
      if mediaType.isEqualToString(kUTTypeImage as! String) {
        image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image }
        println("picked something")
      
      
      myMeMe = MeMe(topText: topText.text, bottomText: bottomText.text, image: imageView.image!,memImage: memImage )
      
      myMeMeArray.append(MeMe(topText: topText.text, bottomText: bottomText.text, image: imageView.image!, memImage: generateMemedImage() ))
      
      println(myMeMe.topText)

    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
      self.dismissViewControllerAnimated(true, completion: nil)
      println("did cancel")
    }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    topText.text = "TOP"
    topText.defaultTextAttributes = memeTextAttributes
    topText.textAlignment = .Center
    bottomText.text = "BOTTOM"
    bottomText.defaultTextAttributes = memeTextAttributes
    bottomText.textAlignment = .Center

    topText.delegate = self
    bottomText.delegate = self
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  
  @IBAction func activityView () {
    // let image = UIImage()
    
    
    // imageView.image = myMeMeArray[1].memImage
    
    let nextViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    //presentViewController(nextViewController, animated: true, completion: nil)
  }
  
  @IBAction func alertView () {
    let controller = UIAlertController()
    controller.title = "This is the title"
    controller.message = "Hope it is going well"
    
    // let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { action in self.dismissViewControllerAnimated(true, completion: nil) } )
    let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) { action in self.dismissViewControllerAnimated(true, completion: nil) }
    
    controller.addAction(alertAction)
    //self.presentViewController(controller, animated: true, completion: nil)
    self.presentViewController(controller, animated: true) {action in println("finished AlertView")}
   }

  
  func generateMemedImage() -> UIImage {
    
    // TODO: Hide toolbar and navbar
    self.toolBar.hidden = true
    
    // Render view to an image
    UIGraphicsBeginImageContext(self.view.frame.size)
    self.view.drawViewHierarchyInRect(self.view.frame,afterScreenUpdates: true)
    let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    // TODO:  Show toolbar and navbar
    self.toolBar.hidden = false

    
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
    println("In textFieldShouldReturn")
    if textField.text == "" {
      textField.text = "TOP"
    }
    textField.resignFirstResponder()
    
    return true;
  }
  
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    self.subscribeToKeyboardNotifications()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(true)
    self.unsubscribeFromKeyboardNotifications()
  }
  
  
  
  func subscribeToKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  
  
  func keyboardWillShow(notification: NSNotification) {
    println("in keyboardWillShow")
    if bottomText.isFirstResponder() {
    self.view.frame.origin.y -= getKeyboardHeight(notification)
    println("doing bottom - moving the screen") }
  }
  
  
  func keyboardWillHide(notification: NSNotification) {
    println("in keyboardWillHide")

    if self.view.frame.origin.y != 0{
    self.view.frame.origin.y += getKeyboardHeight(notification)
      println(" doing bottom - putting screen back") }
  }
  
  
  func getKeyboardHeight(notification: NSNotification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
    return keyboardSize.CGRectValue().height
  }
}



  





