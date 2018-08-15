//
//  CannonPhsyicsController.swift
//  AppLab
//
//  Created by Omar Alejel on 5/15/16.
//  Copyright © 2016 omar alejel. All rights reserved.
//

import UIKit
import SpriteKit

class DonutPhsyicsController: ExperimentViewController, UITextFieldDelegate, DirectionControlDelegate {

    let bounds = UIScreen.main.bounds
    
    var spriteScene: DonutScene!
    
    @IBOutlet var controlView: DirectionControlView!
    
    @IBOutlet var spriteView: SKView!
    
//    var visibleRect: CGRect!
    
    var drew = false
    var viewHasLoaded = false
    
    var accelerationChart: LineChart!
    var velocityChart: LineChart!
    
    override func viewDidDisappear(_ animated: Bool) {
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
        viewHasLoaded = true
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
    
    
    func newPoint(_ p: CGPoint) {
        spriteScene.pushDonut(p)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for v in view.subviews {
            v.resignFirstResponder()
        }
    }
    
    
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    override var canResignFirstResponder : Bool {
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        return true
    }
    
    


    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !drew {
            if viewHasLoaded {
                spriteScene = DonutScene(size: spriteView.frame.size)
                spriteScene.backgroundColor = UIColor.white
                spriteScene.scaleMode = .aspectFit
                spriteView.presentScene(spriteScene)
                spriteScene.donutController = self
                drew = true
                
                controlView.directionDelegate = self
                
                
                accelerationChart = LineChart(frame: CGRect(x: 0, y: spriteView.frame.origin.y, width: 100, height: 100))
                accelerationChart.addLine([0])
                
                accelerationChart.animation.enabled = false
                accelerationChart.lineWidth = 1
                accelerationChart.dots.innerRadiusHighlighted = 0
                view.addSubview(accelerationChart)
                
                let accelerationLabel = UILabel()
                accelerationLabel.text = "Acceleration"
                
                accelerationLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 1, alpha: 1)
                accelerationLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
                view.addSubview(accelerationLabel)
                accelerationLabel.sizeToFit()
                
                velocityChart = LineChart(frame: CGRect(x: spriteView.frame.size.width - 100, y: spriteView.frame.origin.y, width: 100, height: 100))
                velocityChart.addLine([0])
                
                velocityChart.animation.enabled = false
                velocityChart.lineWidth = 1
                velocityChart.dots.innerRadiusHighlighted = 0
                velocityChart.colors = [UIColor.red]
                
                view.addSubview(velocityChart)
                
                let velocityLabel = UILabel()
                velocityLabel.text = "Speed"
                
                velocityLabel.textColor = UIColor.red
                velocityLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
                view.addSubview(velocityLabel)
                velocityLabel.sizeToFit()
                
                let labelCenterY = accelerationChart.frame.origin.y + accelerationChart.frame.size.height + (accelerationLabel.frame.size.height / 2) - 4
                
                velocityLabel.center = CGPoint(x: velocityChart.center.x, y: labelCenterY)
                accelerationLabel.center = CGPoint(x: accelerationChart.center.x, y: labelCenterY)
            }
        } else {
            spriteScene.size = spriteView.frame.size
        }
    }
    
    
    

}
