//
//  DetailViewController.swift
//  Experiment
//
//  Created by Steven Hertz on 6/19/15.
//  Copyright (c) 2015 Steven Hertz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var topLabel: UILabel!
  
  @IBOutlet weak var bottomLabel: UILabel!
  
  @IBOutlet weak var memimg: UIImageView!
  
  var passedTopLabel = ""
  
  var passedBottomLabel = ""
  
  var passedMemimg = UIImage()
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        topLabel.text = passedTopLabel
        bottomLabel.text = passedBottomLabel
        memimg.image = passedMemimg

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    self.tabBarController?.tabBar.hidden = true
    
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(true)
    self.tabBarController?.tabBar.hidden = false
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
