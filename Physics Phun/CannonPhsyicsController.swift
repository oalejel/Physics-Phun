//
//  CannonPhsyicsController.swift
//  AppLab
//
//  Created by Omar Alejel on 5/15/16.
//  Copyright © 2016 omar alejel. All rights reserved.
//

import UIKit
import SpriteKit

class CannonPhsyicsController: UIViewController, UITextFieldDelegate {

    let bounds = UIScreen.mainScreen().bounds
    
    var spriteScene: CannonScene!
    
    @IBOutlet var spriteView: SKView!
    
    var visibleRect: CGRect!
    
    var drew = false
    var viewLoaded = false

    @IBOutlet var angleField: UITextField!
    @IBOutlet var angleSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Cannon 🚀"
        
        // Do any additional setup after loading the view.
        
        angleField.delegate = self
        
        spriteView.showsFPS = true
        spriteView.showsNodeCount = true
        viewLoaded = true
        
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
    
    
    
    func updateCannonAngle() {
        spriteScene.setCannonAngle(angleSlider.value)
    }
    
    
    
    @IBAction func angleFieldChanged(sender: UITextField) {
        guard let number = Float(sender.text!) else {
            sender.text = "0"
            angleSlider.value = 0
            updateCannonAngle()
            
            return
        }
        
        angleSlider.value = number
        updateCannonAngle()
    }
    
    @IBAction func angleSliderChanged(sender: UISlider) {
        angleField.text = "\(angleSlider.value)"
        updateCannonAngle()
    }
    
    @IBAction func launchPressed(sender: UIButton) {
        spriteScene.launch(angleSlider.value, speed: 600)
    }

    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !drew {
            if viewLoaded {
                spriteScene = CannonScene(size: spriteView.frame.size)
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
