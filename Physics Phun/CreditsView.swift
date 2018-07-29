//
//  CreditsView.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 7/29/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import UIKit
import MessageUI

class CreditsView: UICollectionReusableView, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var contactButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if !MFMailComposeViewController.canSendMail() {
            contactButton.isHidden = true
        }
    }
    
    @IBAction func contactDeveloper(_ sender: AnyObject) {
        let mailController = MFMailComposeViewController()
        mailController.mailComposeDelegate = self
        mailController.title = "Send Feeback!"
        mailController.setSubject("Feeback for Physics Phun")
        mailController.setToRecipients(["omalsecondary@gmail.com"])
        
        let rootVC = UIApplication.shared.windows.first?.rootViewController!
        if MFMailComposeViewController.canSendMail() {
            rootVC?.present(mailController, animated: true, completion: nil)
        }
    }
    
    @IBAction func rateOnAppStore(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: "itms-apps://itunes.apple.com/app/id1143664786")!)
    }
    //1143664786
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
