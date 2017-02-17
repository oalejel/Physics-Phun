//
//  ExperimentCell.swift
//  Physics Phun
//
//  Created by Omar Alejel on 7/20/16.
//  Copyright © 2016 omaralejel. All rights reserved.
//

import UIKit

class NeverClearButton: UIButton {
    
    override var backgroundColor: UIColor? {
        didSet {
            if CGColorGetAlpha((backgroundColor?.CGColor)!) == 0 {
                 backgroundColor = oldValue
            }
        }
    }
}

class ExperimentCell: UITableViewCell {
    
    @IBOutlet var experimentLabel: UILabel!
    @IBOutlet var experimentImageButton: NeverClearButton!
    
//    override func drawRect(rect: CGRect) {
//        
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        experimentImageButton.layer.cornerRadius = 10
////        experimentImageButton.imageView = UIImageView()
//        experimentImageButton.imageView?.contentMode = .ScaleAspectFit
        experimentImageButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//
//        
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsetsZero
//        layoutMargins = UIEdgeInsetsZero
        
        
        
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        backgroundView?.backgroundColor = UIColor.redColor()
//        // Configure the view for the selected state
//        
//    }
    
    
    
}
