//
//  TapNavigationBar.swift
//  Physics Phun
//
//  Created by Omar Alejel on 7/21/16.
//  Copyright © 2016 omaralejel. All rights reserved.
//

import UIKit

class TapNavigationBar: UINavigationBar {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var completedSqueeze = true
    var pendingOut = false
    
    var shrinkTime = 0.2 ///animation time when shrinking
    var expandTime = 0.2 ///animation time when expanding
    
    
    ///Animates in when touches begin
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        press()
    }
    
    ///animates out when touch ends
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        rescaleButton()
    }
    
    func press() {
        UIView.animateKeyframesWithDuration(shrinkTime, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: { () -> Void in
            self.completedSqueeze = false
            self.topItem?.titleView?.transform = CGAffineTransformScale(self.transform, 0.9, 0.9)
        }) { (done) -> Void in
            self.completedSqueeze = true
            if self.pendingOut {
                self.rescaleButton()
                self.pendingOut = false
            }
        }
    }
    
    func rescaleButton() {
        if completedSqueeze {
            UIView.animateKeyframesWithDuration(expandTime, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: { () -> Void in
                self.topItem?.titleView?.transform = CGAffineTransformScale(self.transform, 1/0.9, 1/0.9)
            }) { (done) -> Void in
                ///completion work once it rescales
            }
        } else {
            pendingOut = true
        }
    }
    

}
