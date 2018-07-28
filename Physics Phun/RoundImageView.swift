//
//  RoundImageView.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 7/22/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import UIKit
import Shimmer

class RoundImageView: FBShimmeringView {
    
    var image: UIImage? = UIImage(named: "newton_example")
    
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupView()
//    }
//
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = rect.size.width / 2
        layer.masksToBounds = true
        
        let context = UIGraphicsGetCurrentContext()
        let lineWidth: CGFloat = 6
        
        let scale = rect.size.width / (image?.size.width ?? rect.size.width)
        let newSize = image?.size.applying(CGAffineTransform(scaleX: scale, y: scale)) ?? .zero
        image?.draw(in: CGRect(origin: .zero, size: newSize))
        
//        let circleRect = CGRect(x: lineWidth / 2, y: lineWidth / 2, width: rect.size.width - lineWidth, height: rect.size.height - lineWidth)
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setFillColor(UIColor.white.cgColor)
        context?.setLineWidth(lineWidth) // note that half of linewidth will be clipped
        context?.addEllipse(in: rect)
        
        context?.strokePath()
    }
 
    
    

}
