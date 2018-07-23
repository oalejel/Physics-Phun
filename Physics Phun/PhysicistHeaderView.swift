//
//  PhysicistHeaderView.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 7/22/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import UIKit
import SafariServices

class PhysicistHeaderView: UICollectionReusableView, SFSafariViewControllerDelegate {
    @IBOutlet weak var wikiButton: UIButton!
    
    @IBOutlet weak var physicistImageView: RoundImageView!
    @IBOutlet weak var physicistNameLabel: UILabel!
    @IBOutlet weak var physicistDescriptionLabel: UILabel!
    @IBOutlet weak var featuredLabel: UILabel!
    
    var wikiURL: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        wikiButton.imageView?.contentMode = .scaleAspectFit
        wikiButton.imageEdgeInsets.left = -5
        wikiButton.imageEdgeInsets.top = 4
        wikiButton.imageEdgeInsets.bottom = 4
        featuredLabel.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func wikiButtonPressed(_ sender: Any) {
        if let url = wikiURL {
            let safariController = SFSafariViewController(url: url)
            UIApplication.shared.keyWindow?.rootViewController?.show(safariController, sender: self)
        }
    }
    
    // call this when ready to reload our physicist
    func newPhysicist() {
        PhysicistOfTheDayManager.shared.update { (name, description, url) in
            DispatchQueue.main.async {
                self.wikiURL = url
                self.physicistNameLabel.text = name
                self.physicistDescriptionLabel.text = description
            }
        }
    }
}
