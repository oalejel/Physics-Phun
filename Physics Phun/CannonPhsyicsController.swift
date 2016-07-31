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
    
    @IBOutlet var speedField: UITextField!
    @IBOutlet var speedSlider: UISlider!
    
    @IBOutlet var fieldField: UITextField!
    @IBOutlet var fieldSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Cannon 🚀"
        let btn = UIButton(type: UIButtonType.InfoLight)
        btn.addTarget(self, action: #selector(CannonPhsyicsController.infoPressed), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
//        navigationItem.rightBarButtonItem?.target = self
//        navigationItem.rightBarButtonItem?.action = #selector(CannonPhsyicsController.infoPressed)
        
        // Do any additional setup after loading the view.
        
        angleField.delegate = self
        
        spriteView.showsFPS = true
        spriteView.showsNodeCount = true
        viewLoaded = true
        
    }
    
    func infoPressed() {
        print("show them some info!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        spriteScene.clear()
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
        spriteScene.updateCannonAngle(angleSlider.value)
    }
    
    
    
    @IBAction func angleFieldChanged(sender: UITextField) {
        guard var number = Float(sender.text!) else {
            sender.text = "0"
            angleSlider.value = 0
            updateCannonAngle()
            
            return
        }
        
        if number > 90 {
            number = 90
            sender.text = "\(number)"
        } else if number < 0 {
            number = 0
            sender.text = "\(number)"
        }
        
        angleSlider.value = number
        updateCannonAngle()
    }
    
    @IBAction func speedFieldChanged(sender: UITextField) {
        guard var number = Float(sender.text!) else {
            sender.text = "0"
            speedSlider.value = 0
            
            return
        }
        
        if number > 500 {
            number = 500
            sender.text = "\(number)"
        } else if number < 1 {
            number = 1
            sender.text = "\(number)"
        }
        
        speedSlider.value = number
    }
    
    
    @IBAction func fieldFieldChanged(sender: UITextField) {
        guard var number = Float(sender.text!) else {
            sender.text = "0"
            fieldSlider.value = 0
            
            return
        }
        
        if number > 40 {
            number = 40
            sender.text = "\(number)"
        } else if number < 9 {
            number = 9
            sender.text = "\(number)"
        }
        
        fieldSlider.value = number
    }
    
    
    
    @IBAction func angleSliderChanged(sender: UISlider) {
        angleField.text = "\(angleSlider.value)"
        updateCannonAngle()
    }
    
    @IBAction func speedSliderChanged(sender: UISlider) {
        speedField.text = "\(speedSlider.value)"
    }
    
    @IBAction func fieldSliderChanged(sender: UISlider) {
        fieldField.text = "\(fieldSlider.value)"
    }
    
    @IBAction func launchPressed(sender: UIButton) {
        spriteScene.launch(angleSlider.value, speed: speedSlider.value, fieldStrength: fieldSlider.value)
    }

    
    @IBAction func clearPressed(sender: AnyObject) {
        spriteScene.clear()
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
