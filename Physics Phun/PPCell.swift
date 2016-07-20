//
//  PPCell.swift
//
//
//  Created by Omar Alejel on 1/31/16.
//  Copyright © 2016 omaralejel. All rights reserved.
//

import UIKit

class PPCell: UICollectionViewCell {
    
    override func awakeFromNib() {
//        layer.cornerRadius = 10
//        clipsToBounds = true
    }
    
    var completedSqueeze = true
    var pendingOut = false

//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        super.touchesBegan(touches, withEvent: event)
//        press()
//    }
//    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        super.touchesEnded(touches, withEvent: event)
//        rescaleButton()
//    }
    
    func press() {
        UIView.animateKeyframesWithDuration(0.1, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: { () -> Void in
            self.completedSqueeze = false
            self.transform = CGAffineTransformScale(self.transform, 0.9, 0.9)
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
            UIView.animateKeyframesWithDuration(0.2, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: { () -> Void in
                self.transform = CGAffineTransformScale(self.transform, 1/0.9, 1/0.9)
                }) { (done) -> Void in
                    
            }
        } else {
            pendingOut = true
        }
    }

    
//    -(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//    {
//    UITextView *tv = object;
//    CGFloat topCorrect = ([tv bounds].size.height - [tv     contentSize].height * [tv zoomScale])/2.0;
//    topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
//    [tv setContentInset:UIEdgeInsetsMake(topCorrect,0,0,0)];
//    }
//    
//    - (void) viewWillAppear:(BOOL)animated
//    {
//    [super viewWillAppear:NO];
//    [questionTextView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
//    }

    
}
