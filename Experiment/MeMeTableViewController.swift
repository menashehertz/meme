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
   }

  override func viewWillAppear(animated: Bool)  {
    super.viewWillAppear(true)
    
    if (self.appDelg).myMeMeArray.count > 0 {
      memeTable.reloadData()
      return
    }
    doNewMem()
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.appDelg).myMeMeArray.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memecell", forIndexPath: indexPath) as! MeMeTableViewCell
        cell.titleLabel.text = self.appDelg.myMeMeArray[indexPath.row].topText
        cell.memimg.image = self.appDelg.myMeMeArray[indexPath.row].memImage
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
      return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
      if editingStyle == .Delete {
        // Delete the row from the data source
        appDelg.myMeMeArray.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        tableView.reloadData()
      }
    }

  func doNewMem() {
    var controller : ViewController
    
    controller = self.storyboard?.instantiateViewControllerWithIdentifier("edt") as! ViewController
        
    if let navigationController = self.navigationController {
      navigationController.pushViewController(controller, animated: true)    }

  }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
      let controller = segue.destinationViewController as! DetailViewController
      let pointer = self.memeTable.indexPathForSelectedRow()?.row
      controller.passedTopLabel = self.appDelg.myMeMeArray[pointer!].topText
      controller.passedBottomLabel = self.appDelg.myMeMeArray[pointer!].bottomText
      controller.passedMemimg = self.appDelg.myMeMeArray[pointer!].image
    }
}
