//
//  PhysicistHeaderView.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 7/22/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import UIKit
import SafariServices
import Shimmer

class PhysicistHeaderView: UICollectionReusableView, SFSafariViewControllerDelegate {
    @IBOutlet weak var wikiButton: UIButton!
    
    @IBOutlet weak var physicistImageView: RoundImageView!
    @IBOutlet weak var physicistNameLabel: UILabel!
    @IBOutlet weak var physicistDescriptionLabel: UILabel!
    @IBOutlet weak var featuredLabel: UILabel!
    
    var wikiURL: URL?
    var didAwakeOnce = false
    
    // Layout formatting note
    // Need description label to have a *minimum* size since users who have larger system font sizes will need it
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        // Note that dequeueing header views will cause this method to be called often
        wikiButton.imageView?.contentMode = .scaleAspectFit
        wikiButton.imageEdgeInsets.left = -5
        wikiButton.imageEdgeInsets.top = 4
        wikiButton.imageEdgeInsets.bottom = 4
        featuredLabel.adjustsFontSizeToFitWidth = true
        
        // show loading status by shimmering
        physicistImageView.isShimmering = true
    }
    
    @IBAction func wikiButtonPressed(_ sender: Any) {
        if let url = wikiURL {
            let safariController = SFSafariViewController(url: url)
            safariController.modalPresentationCapturesStatusBarAppearance = true
            safariController.setNeedsStatusBarAppearanceUpdate()
            UIApplication.shared.keyWindow?.rootViewController?.present(safariController, animated: true, completion: nil)
        }
    }
    
    // call this when ready to reload our physicist
    func newPhysicist() {
        PhysicistOfTheDayManager.shared.update { (name, description, url, image) in
            DispatchQueue.main.async {
                self.wikiURL = url
                self.physicistNameLabel.text = name
                self.physicistDescriptionLabel.text = description
                self.physicistImageView.image = image
                self.physicistImageView.setNeedsDisplay()
            }
        }
    }
}
