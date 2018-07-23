//
//  RoundImageView.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 7/22/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import UIKit

class RoundImageView: UIView {
    
    var image: UIImage? = UIImage(named: "newton_example")
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
        
        // since we may load this from a nib, we need to tell screen that this view is dirty
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        image?.draw(in: rect)
        
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setFillColor(UIColor.white.cgColor)
        context?.setLineWidth(6) // note that half this linewidth will be clipped
        context?.addEllipse(in: rect)
        
        context?.strokePath()
    }
 
    
    

}
