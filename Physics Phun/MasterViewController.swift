//
//  MasterViewController.swift
//  Physics Phun
//
//  Created by Omar Alejel on 5/7/16.
//  Copyright © 2016 omaralejel. All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController {
    let cellID = "cell"
    var dataTree: [String:[(demoName: String, demoClass: AnyClass)]] = ["Motion":[("Cannon", CannonPhsyicsController.self)], "Gases":[("Air Box", CannonPhsyicsController.self)]]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertNewObject(_:)))
//        self.navigationItem.rightBarButtonItem = addButton
        
        collectionView?.registerNib(UINib(nibName: "ExperimentViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as? ExperimentViewCell {
//            
//            return cell
//        } else {
//            return collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath)
//        }
        return UICollectionViewCell()
    }


    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                let controller = (segue.destinationViewController as! UINavigationController)
////                controller.topViewController
////                controller.detailItem =
//                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//                controller.navigationItem.leftItemsSupplementBackButton = true
//                if !showMainDetail {
//                    let treeKeys = Array(dataTree.keys)
//                    let treeNode = dataTree[treeKeys[indexPath.section]]
//                    let itemClass = treeNode![indexPath.row].demoClass as! UIViewController.Type
//                    
//                    controller.viewControllers[0] = itemClass.init()
//                }
//                
//                showMainDetail = false
//            }
//        }
    }

    // MARK: - Table View

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return dataTree.count
//    }
//    
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return Array(dataTree.keys)[section]
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let treeKeys = Array(dataTree.keys)
//        let treeNode = dataTree[treeKeys[section]]
//        return treeNode!.count
//    }
//
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
//
//        let treeKeys = Array(dataTree.keys)
//        let treeNode = dataTree[treeKeys[indexPath.section]]
//        let nodeItem = treeNode![indexPath.row]
//        cell.textLabel!.text = nodeItem.demoName
//        return cell
//    }
//
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }

//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            objects.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
////        splitViewController?.viewControllers = [(splitViewController?.viewControllers[0])!, CannonViewController()]
////        dispatch_async(dispatch_get_main_queue()) { 
////            print(self.splitNavController.viewControllers)
////            self.splitNavController.viewControllers[0].view.backgroundColor = UIColor.redColor()
////        }
//        
//    }


}

