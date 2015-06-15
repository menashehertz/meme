//
//  ViewController.swift
//  Experiment
//
//  Created by Steven Hertz on 6/10/15.
//  Copyright (c) 2015 Steven Hertz. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  var memeTextController = MeMeTextController()
  
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
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
      self.dismissViewControllerAnimated(true, completion: nil)
      println("did cancel")
    }


  // Helper Functions
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    topText.text = "TOP"
    topText.defaultTextAttributes = memeTextAttributes
    topText.textAlignment = .Center
    bottomText.text = "BOTTOM"
    bottomText.textAlignment = .Center

    topText.delegate = memeTextController
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  
  @IBAction func activityView () {
    // let image = UIImage()
    let nextViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    presentViewController(nextViewController, animated: true, completion: nil)
  }
  
  @IBAction func alertView () {
    let controller = UIAlertController()
    controller.title = "This is the title"
    controller.message = "Hope it is going well"
    
    // let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { action in self.dismissViewControllerAnimated(true, completion: nil) } )
    let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) { action in self.dismissViewControllerAnimated(true, completion: nil) }
    
    controller.addAction(alertAction)
    self.presentViewController(controller, animated: true, completion: nil)
    
  }

  
  
}




