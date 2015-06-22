//
//  MeMeTableViewController.swift
//  Experiment
//
//  Created by Steven Hertz on 6/17/15.
//  Copyright (c) 2015 Steven Hertz. All rights reserved.
//

import UIKit

class MeMeTableViewController: UITableViewController {
  
  let appDelg = UIApplication.sharedApplication().delegate as! AppDelegate

  @IBOutlet var memeTable: UITableView!
  
  @IBAction func addMem () {
    doNewMem()
  }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

  override func viewWillAppear(animated: Bool)  {
    super.viewWillAppear(true)
    
    if (self.appDelg).myMeMeArray.count > 0 {
      println("greater than 0")
      memeTable.reloadData()
      return
    }
    
    doNewMem()
    
      /* This is a manual seguay.
      - 1. we define an object to contain the viewcontroller
      - we instantiate the WimviewController from Storyboard
      - we populate it wuth any data needed
      - We present it
      */

//    var controller : ViewController //1
//      
//      controller = self.storyboard?.instantiateViewControllerWithIdentifier("edt") as! ViewController //2
//      
//      println("rock")
//      
//      if let navigationController = self.navigationController {
//        navigationController.pushViewController(controller, animated: true)
//    }
    
      
      // self.presentViewController(controller, animated: true, completion: nil) //4
      
    }

  
  
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return (self.appDelg).myMeMeArray.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("in cellfrom row at indexpath")
        let cell = tableView.dequeueReusableCellWithIdentifier("memecell", forIndexPath: indexPath) as! MeMeTableViewCell
        cell.titleLabel.text = self.appDelg.myMeMeArray[indexPath.row].topText
        cell.memimg.image = self.appDelg.myMeMeArray[indexPath.row].memImage
      
        // Configure the cell...
      

        return cell
    }
  
  func doNewMem() {
    var controller : ViewController //1
    
    controller = self.storyboard?.instantiateViewControllerWithIdentifier("edt") as! ViewController //2
        
    if let navigationController = self.navigationController {
      navigationController.pushViewController(controller, animated: true)    }

  }
  
  
  
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
      let controller = segue.destinationViewController as! DetailViewController
      
      let pointer = self.memeTable.indexPathForSelectedRow()?.row
      controller.passedTopLabel = self.appDelg.myMeMeArray[pointer!].topText
      controller.passedBottomLabel = self.appDelg.myMeMeArray[pointer!].bottomText
      controller.passedMemimg = self.appDelg.myMeMeArray[pointer!].image
      
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
  

}
