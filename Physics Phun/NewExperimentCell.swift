//
//  NewExperimentCell.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 7/22/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import UIKit

class NewExperimentCell: UICollectionViewCell {

    @IBOutlet weak var experimentImageView: UIImageView!
    @IBOutlet weak var experimentTitleLabel: UILabel!
    
    static let blueprintImage = UIImage(named: "blueprint_atlas")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 10
//        layer.masksToBounds = true // layer clipping
        clipsToBounds = true // view clipping
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let actualSize = NewExperimentCell.blueprintImage!.size
        
        let randomXOffset = -CGFloat(arc4random() % UInt32((actualSize.width - rect.size.height)))
        let randomYOffset = -CGFloat(arc4random() % UInt32((actualSize.height - rect.size.height)))
//        context?.saveGState() // will return to this state once we draw our image and cut part of it out
        let offsetRect = CGRect(x: randomXOffset, y: randomYOffset, width: actualSize.width, height: actualSize.height)
        context?.draw(NewExperimentCell.blueprintImage!.cgImage!, in: offsetRect)
    }

}
