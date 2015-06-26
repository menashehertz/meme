//
//  MeMeCollectionViewController.swift
//  Experiment
//
//  Created by Steven Hertz on 6/18/15.
//  Copyright (c) 2015 Steven Hertz. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class MeMeCollectionViewController: UICollectionViewController {
  
  let appDelg = UIApplication.sharedApplication().delegate as! AppDelegate

  @IBOutlet var memecoll: UICollectionView!

  @IBAction func makeNewMem(sender: AnyObject) {
    doNewMem()
  }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

  override func viewWillAppear(animated: Bool)  {
    super.viewWillAppear(true)
      memecoll.reloadData()
      return
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return (self.appDelg).myMeMeArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
    
        cell.memimg.image = self.appDelg.myMeMeArray[indexPath.row].memImage

    
        return cell
    }
  
  
  func doNewMem() {
    var controller : ViewController
    controller = self.storyboard?.instantiateViewControllerWithIdentifier("edt") as! ViewController //2
        
    if let navigationController = self.navigationController {
      navigationController.pushViewController(controller, animated: true)    }
    
  }
  


  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    let controller = segue.destinationViewController as! DetailViewController
    
    let pointer = self.memecoll.indexPathForCell(sender as! UICollectionViewCell)?.row

    controller.passedTopLabel = self.appDelg.myMeMeArray[pointer!].topText
    controller.passedBottomLabel = self.appDelg.myMeMeArray[pointer!].bottomText
    controller.passedMemimg = self.appDelg.myMeMeArray[pointer!].image
  }

  
    
 
}
