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

    @IBAction func contactDeveloper(_ sender: AnyObject) {
        let mailController = MFMailComposeViewController()
        mailController.mailComposeDelegate = self
        mailController.title = "Send Feeback!"
        mailController.setSubject("Feeback for Physics Phun")
        mailController.setToRecipients(["omalsecondary@gmail.com"])
        
        let rootVC = UIApplication.shared.windows.first?.rootViewController!
        if rootVC is UINavigationController {
            if MFMailComposeViewController.canSendMail() {
                (rootVC as! UINavigationController).topViewController!.present(mailController, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func rateOnAppStore(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: "itms-apps://itunes.apple.com/app/id1143664786")!)
    }
    //1143664786
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
        isHighlighted = false
        // Configure the view for the selected state
    }
    
}
