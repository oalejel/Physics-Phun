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
            if (backgroundColor?.cgColor)!.alpha == 0 {
                 backgroundColor = oldValue
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //get graphics context and set settings
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor(red: 0.6, green: 0.4, blue: 0.2, alpha: 0.4).cgColor)
        context?.setLineWidth(1)
//        context?.setFillColor(UIColor.brown.cgColor)
        
        for i in 1...Int(rect.width / 20) {
            let verticalLine = UIBezierPath()
            verticalLine.move(to: CGPoint(x: CGFloat(i * 20), y: 0))
            verticalLine.addLine(to: CGPoint(x: CGFloat(i * 20), y: rect.height))
            verticalLine.stroke()
        }
        
        for i in 1...Int(rect.height / 20) {
            let horizontalLine = UIBezierPath()
            horizontalLine.move(to: CGPoint(x: 0, y: CGFloat(i * 20)))
            horizontalLine.addLine(to: CGPoint(x: rect.width, y: CGFloat(i * 20)))
            horizontalLine.stroke()
        }
    }
}

class ExperimentCell: UITableViewCell {
    
    @IBOutlet var experimentLabel: UILabel!
    @IBOutlet var experimentImageButton: NeverClearButton!
    
//    override func draw(_ rect: CGRect) {
//        
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        experimentImageButton.layer.cornerRadius = 10
        experimentImageButton.clipsToBounds = true
        
////        experimentImageButton.imageView = UIImageView()
//        experimentImageButton.imageView?.contentMode = .ScaleAspectFit
        experimentImageButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//
//        
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
//        layoutMargins = UIEdgeInsetsZero
        
        
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        backgroundView?.backgroundColor = UIColor.redColor()
//        // Configure the view for the selected state
//        
//    }
    
    
    
}
