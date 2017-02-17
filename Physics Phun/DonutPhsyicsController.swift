//
//  CannonPhsyicsController.swift
//  AppLab
//
//  Created by Omar Alejel on 5/15/16.
//  Copyright © 2016 omar alejel. All rights reserved.
//

import UIKit
import SpriteKit

class DonutPhsyicsController: UIViewController, UITextFieldDelegate, DirectionControlDelegate {

    let bounds = UIScreen.mainScreen().bounds
    
    var spriteScene: DonutScene!
    
    @IBOutlet var controlView: DirectionControlView!
    
    @IBOutlet var spriteView: SKView!
    
    var visibleRect: CGRect!
    
    var drew = false
    var viewLoaded = false
    
    var accelerationChart: LineChart!
    var velocityChart: LineChart!
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        spriteView.presentScene(nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "The Flying Donut 🍩"
/*
        let btn = UIButton(type: UIButtonType.InfoLight)
        btn.addTarget(self, action: #selector(CannonPhsyicsController.infoPressed), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
 */
        
        controlView.layer.cornerRadius = 10
        controlView.clipsToBounds = true
        
        spriteView.showsFPS = false
        spriteView.showsNodeCount = false
        viewLoaded = true
    }
    
    func infoPressed() {
        print("show them some info!")
        let infoTextVC = InfoTextViewController()
//        infoTextVC.textView
        navigationController?.pushViewController(infoTextVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func newPoint(p: CGPoint) {
        spriteScene.pushDonut(p)
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for v in view.subviews {
            v.resignFirstResponder()
        }
    }
    
    
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func canResignFirstResponder() -> Bool {
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        return true
    }
    
    


    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !drew {
            if viewLoaded {
                spriteScene = DonutScene(size: spriteView.frame.size)
                spriteScene.backgroundColor = UIColor.whiteColor()
                spriteScene.scaleMode = .AspectFit
                spriteView.presentScene(spriteScene)
                spriteScene.donutController = self
                drew = true
                
                controlView.directionDelegate = self
                
                
                accelerationChart = LineChart(frame: CGRectMake(0, spriteView.frame.origin.y, 100, 100))
                accelerationChart.addLine([0])
                
                accelerationChart.animation.enabled = false
                accelerationChart.lineWidth = 1
                accelerationChart.dots.innerRadiusHighlighted = 0
                view.addSubview(accelerationChart)
                
                let accelerationLabel = UILabel()
                accelerationLabel.text = "Acceleration"
                
                accelerationLabel.textColor = UIColor.blueColor()
                accelerationLabel.font = UIFont(name: "Helvetica", size: 10)
                view.addSubview(accelerationLabel)
                accelerationLabel.sizeToFit()
                accelerationLabel.center = accelerationChart.center
                
                
                velocityChart = LineChart(frame: CGRectMake(spriteView.frame.size.width - 100, spriteView.frame.origin.y, 100, 100))
                velocityChart.addLine([0])
                
                velocityChart.animation.enabled = false
                velocityChart.lineWidth = 1
                velocityChart.dots.innerRadiusHighlighted = 0
                velocityChart.colors = [UIColor.redColor()]
                
                view.addSubview(velocityChart)
                
                let velocityLabel = UILabel()
                velocityLabel.text = "Speed"
                
                velocityLabel.textColor = UIColor.redColor()
                velocityLabel.font = UIFont(name: "Helvetica", size: 10)
                view.addSubview(velocityLabel)
                velocityLabel.sizeToFit()
                velocityLabel.center = velocityChart.center
            }
        } else {
            spriteScene.size = spriteView.frame.size
        }
    }
    
    
    

}
