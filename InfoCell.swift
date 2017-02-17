//
//  InfoCell.swift
//  Physics Phun
//
//  Created by Omar Alejel on 8/12/16.
//  Copyright © 2016 omaralejel. All rights reserved.
//

import UIKit
import MessageUI

class InfoCell: UITableViewCell, MFMailComposeViewControllerDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    @IBAction func contactDeveloper(sender: AnyObject) {
        let mailController = MFMailComposeViewController()
        mailController.mailComposeDelegate = self
        mailController.title = "Send Feeback!"
        mailController.setSubject("Feeback for Physics Phun")
        mailController.setToRecipients(["omalsecondary@gmail.com"])
        
        let rootVC = UIApplication.sharedApplication().windows.first?.rootViewController!
        if rootVC is UINavigationController {
            if MFMailComposeViewController.canSendMail() {
                (rootVC as! UINavigationController).topViewController!.presentViewController(mailController, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func rateOnAppStore(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "itms-apps://itunes.apple.com/app/id1143664786")!)
    }
    //1143664786
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
        highlighted = false
        // Configure the view for the selected state
    }
    
}
