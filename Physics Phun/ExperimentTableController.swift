//
//  ExperimentTableController.swift
//  Physics Phun
//
//  Created by Omar Alejel on 7/20/16.
//  Copyright © 2016 omaralejel. All rights reserved.
//

import UIKit

class ExperimentTableController: UITableViewController, UINavigationControllerDelegate {
    
    fileprivate let cellID = "cell"
    fileprivate let infoCellID = "infoCell"
    let bounds = UIScreen.main.bounds
    
    var experiments: [[(demoName: String, demoClass: AnyClass)]] = [
        [("Cannon", CannonPhsyicsController.self), ("The Flying Donut", DonutPhsyicsController.self)],
        [("Air Box", AirBoxPhsyicsController.self)],
        [("Circuit VIRP", VIRPPhsyicsController.self), ("Resistance in a Wire", ResistivityPhsyicsController.self)],
        //[("Polarized Neutron Reflectometry", NeutronPhsyicsController.self)]
    ]
    
    var experimentSectionTitles = ["Motion and Forces 🚀", "Gases 🌫", "Electricity & Circuits ⚡️"]//, "Solid State Physics ⚛"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        tableView.register(UINib(nibName: "ExperimentCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        tableView.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: infoCellID)
        
        navigationController?.delegate = self
        
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        tableView.layoutMargins = UIEdgeInsetsZero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return experiments.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section >= experiments.count {
            print("never mind")
            return 1
        }
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

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard experimentSectionTitles.count > section else {
            return nil
        }
        
        let header = UITableViewHeaderFooterView(reuseIdentifier: "header")
        header.contentView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        header.textLabel?.text = "\(experimentSectionTitles[section])"
        header.textLabel?.textColor = UIColor.lightGray
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section >= experiments.count {
            return 0
        }
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section < experiments.count {
            return bounds.size.width * 0.6
        }
        
        return bounds.size.width * 0.3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section >= experiments.count {
            if let c = tableView.dequeueReusableCell(withIdentifier: infoCellID) as? InfoCell {
                return c
            }
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ExperimentCell else {
            return UITableViewCell()
        }
        

        cell.selectionStyle = .gray
        cell.experimentImageButton.imageView?.contentMode = .scaleAspectFit
        
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cell.selectedBackgroundView = v
        
        let experimentName = experiments[indexPath.section][indexPath.row].demoName
        cell.experimentLabel.text = experimentName
        if let image = UIImage(named: "\(experimentName)_exp.png") {
            cell.experimentImageButton.setImage(image.withRenderingMode(.alwaysOriginal), for: UIControlState())
        }
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section < experiments.count {
            let experimentClass = experiments[indexPath.section][indexPath.row].demoClass as! UIViewController.Type
            let viewController = experimentClass.init()
            
            navigationController?.pushViewController(viewController, animated: true)
        }
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
