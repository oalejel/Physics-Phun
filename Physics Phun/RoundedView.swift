//
//  RoundedView.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 3/18/17.
//  Copyright © 2017 omaralejel. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    
    let standardCornerRadius: CGFloat = 15
   
    init(frame: CGRect, cornerRadius: CGFloat) {
        super.init(frame: frame)
        layer.cornerRadius = cornerRadius
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = standardCornerRadius
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = standardCornerRadius
    }
    
    
}
