//
//  ExperimentCell.swift
//  Physics Phun
//
//  Created by Omar Alejel on 7/20/16.
//  Copyright © 2016 omaralejel. All rights reserved.
//

import UIKit

class InsetImageView: UIImageView {
    let inset: CGFloat = 10
    override func alignmentRectInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    override func alignmentRectForFrame(frame: CGRect) -> CGRect {
        return CGRectInset(frame, inset * 2, inset * 2)
    }
}

class ExperimentCell: UITableViewCell {
    
    @IBOutlet var experimentLabel: UILabel!
    @IBOutlet var experimentImageView: InsetImageView!
    
//    override func drawRect(rect: CGRect) {
//        
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        experimentImageView.layer.cornerRadius = 10
        
        experimentImageView.contentMode = .ScaleAspectFit
        experimentImageView.contentScaleFactor = 0.9
        experimentImageView.alignmentRectInsets()
    }

    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
