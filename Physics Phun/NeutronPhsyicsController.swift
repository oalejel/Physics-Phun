//
//  NeutronPhsyicsController.swift
//  AppLab
//
//  Created by Omar Alejel on 5/15/16.
//  Copyright © 2016 omar alejel. All rights reserved.
//

import UIKit
import SpriteKit

class NeutronPhsyicsController: UIViewController, UITextFieldDelegate {

    let bounds = UIScreen.mainScreen().bounds
    
    var spriteScene: NeutronScene!
    
    @IBOutlet var angleSlider: UISlider!
    @IBOutlet var pSlider: UISlider!
    @IBOutlet var mSlider: UISlider!
    @IBOutlet var magnetSegment: UISegmentedControl!
    
    @IBOutlet var spriteView: SKView!
    
    var visibleRect: CGRect!
    
    
    

    
    var drew = false
    var viewLoaded = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "PNR 🔴"
        let btn = UIButton(type: UIButtonType.InfoLight)
        btn.addTarget(self, action: #selector(CannonPhsyicsController.infoPressed), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
        spriteView.showsFPS = true
        spriteView.showsNodeCount = true
        viewLoaded = true
    }
    
    @IBAction func startButtonPressed(sender: AnyObject) {
        spriteScene.startNeutronBeam(5)
    }
    
    func infoPressed() {
        print("show them some info!")
    }
    
    

    @IBAction func angleSliderChanged(sender: UISlider) {
        spriteScene.updateAngle(sender.value)
    }
    
    @IBAction func polarizationSegmentChanged(sender: AnyObject) {
        spriteScene.spinDownMode = (sender.selectedSegmentIndex == 0) ? false : true
    }

    @IBAction func magnetSegmentChanged(sender: UISegmentedControl) {
        spriteScene.netFieldExists = (sender.selectedSegmentIndex == 0) ? false : true
    }
    
    @IBAction func thicknessSliderChanged(sender: UISlider) {
        let moveDown = SKAction.moveToY(spriteScene.layer2Y + CGFloat(sender.value), duration: 0.2)
        spriteScene.layer2.runAction(moveDown)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                spriteScene = NeutronScene(size: spriteView.frame.size)
                spriteScene.backgroundColor = UIColor.whiteColor()
                spriteScene.scaleMode = .AspectFit
                spriteView.presentScene(spriteScene)
                drew = true
            }
            
        } else {
            spriteScene.size = spriteView.frame.size
        }
    }
    
    
    

}
