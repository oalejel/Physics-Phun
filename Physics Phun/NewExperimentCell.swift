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
        layer.cornerRadius = 10
        experimentImageView.contentMode = .scaleAspectFit
        clipsToBounds = true // view clipping
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let actualSize = NewExperimentCell.blueprintImage!.size
        
        let randomXOffset = -CGFloat(arc4random() % UInt32((actualSize.width - rect.size.width)))
        let randomYOffset = -CGFloat(arc4random() % UInt32((actualSize.height - rect.size.height)))
        let offsetRect = CGRect(x: randomXOffset, y: randomYOffset, width: actualSize.width, height: actualSize.height)
        context?.draw(NewExperimentCell.blueprintImage!.cgImage!, in: offsetRect)
    }

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.contentView.alpha = 0.8
            } else {
                self.transform = CGAffineTransform.identity
                self.contentView.alpha = 1
            }
        }
    }
    
}
