//
//  ExperimentTableController.swift
//  Physics Phun
//
//  Created by Omar Alejel on 7/20/16.
//  Copyright © 2016 omaralejel. All rights reserved.
//

import UIKit

class ExperimentTableController: UITableViewController {
    
    private let cellID = "cell"
    let bounds = UIScreen.mainScreen().bounds
    
    var experiments: [[(demoName: String, demoClass: AnyClass)]] = [
        [("Cannon", CannonPhsyicsController.self), ("Car Crash", CannonPhsyicsController.self)],
        [("Air Box", CannonPhsyicsController.self)],
        [("VIRP", CannonPhsyicsController.self), ("Resistance in a wire", CannonPhsyicsController.self), ]
    ]
    
    var experimentSectionTitles = ["Motion 🚀", "Gases 🌫", "Electricity & Circuits ⚡️"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        tableView.registerNib(UINib(nibName: "ExperimentCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableView.rowHeight = bounds.size.width * 0.6
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return experiments.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return experiments[section].count
    }
    
    
    
    //HEADERS
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        guard experimentSectionTitles.count > section else {
//            return nil
//        }
//        
//        return experimentSectionTitles[section]
//    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard experimentSectionTitles.count > section else {
            return nil
        }
        
        let header = UITableViewHeaderFooterView(reuseIdentifier: "header")
        header.contentView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        header.textLabel?.text = "  \(experimentSectionTitles[section])"
        header.textLabel?.textColor = UIColor.lightGrayColor()
        return header
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as? ExperimentCell else {
            return UITableViewCell()
        }
        
        let experimentName = experiments[indexPath.section][indexPath.row].demoName
        cell.experimentLabel.text = experimentName
        if let image = UIImage(named: "\(experimentName)_exp.png") {
            cell.experimentImageView.image = image
        }
        
        return cell
    }
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let experimentClass = experiments[indexPath.section][indexPath.row].demoClass as! UIViewController.Type
        let viewController = experimentClass.init()
        
        navigationController?.pushViewController(viewController, animated: true)
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
