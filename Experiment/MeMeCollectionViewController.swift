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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
       return (self.appDelg).myMeMeArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        println("before - in cellfrom row at indexpath")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
        println("after - in cellfrom row at indexpath")
      
      //cell.celllabel.text = "hello"
    
        cell.memimg.image = self.appDelg.myMeMeArray[indexPath.row].memImage

    
        return cell
    }
  
  
  func doNewMem() {
    var controller : ViewController //1
    
    controller = self.storyboard?.instantiateViewControllerWithIdentifier("edt") as! ViewController //2
    
    println("rock")
    
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

  
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
