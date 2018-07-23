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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }

}
