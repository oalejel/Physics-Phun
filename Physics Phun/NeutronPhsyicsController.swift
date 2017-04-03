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

    let bounds = UIScreen.main.bounds
    
    var spriteScene: NeutronScene!
    
    @IBOutlet var angleSlider: UISlider!
    @IBOutlet var pSlider: UISlider!
    @IBOutlet var mSlider: UISlider!
    @IBOutlet var magnetSegment: UISegmentedControl!
    
    @IBOutlet var spriteView: SKView!
    
    var visibleRect: CGRect!
    
    
    

    
    var drew = false
    var viewHasLoaded = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "PNR 🔴"
        /*
        let btn = UIButton(type: UIButtonType.InfoLight)
        btn.addTarget(self, action: #selector(CannonPhsyicsController.infoPressed), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
 */
        
        spriteView.showsFPS = false
        spriteView.showsNodeCount = false
        viewHasLoaded = true
    }
    
    @IBAction func startButtonPressed(_ sender: AnyObject) {
        spriteScene.startNeutronBeam(5)
    }
    
    func infoPressed() {
        print("show them some info!")
    }
    
    

    @IBAction func angleSliderChanged(_ sender: UISlider) {
        spriteScene.updateAngle(sender.value)
    }
    
    @IBAction func polarizationSegmentChanged(_ sender: AnyObject) {
        spriteScene.spinDownMode = (sender.selectedSegmentIndex == 0) ? false : true
    }

    @IBAction func magnetSegmentChanged(_ sender: UISegmentedControl) {
        spriteScene.netFieldExists = (sender.selectedSegmentIndex == 0) ? false : true
    }
    
    @IBAction func thicknessSliderChanged(_ sender: UISlider) {
        let moveDown = SKAction.moveTo(y: spriteScene.layer2Y + CGFloat(sender.value), duration: 0.2)
        spriteScene.layer2.run(moveDown)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                spriteScene = NeutronScene(size: spriteView.frame.size)
                spriteScene.backgroundColor = UIColor.white
                spriteScene.scaleMode = .aspectFit
                spriteView.presentScene(spriteScene)
                drew = true
            }
            
        } else {
            spriteScene.size = spriteView.frame.size
        }
    }
    
    
    

}
