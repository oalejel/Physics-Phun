//
//  CannonPhsyicsController.swift
//  AppLab
//
//  Created by Omar Alejel on 5/15/16.
//  Copyright © 2016 omar alejel. All rights reserved.
//

import UIKit
import SpriteKit

class VIRPPhsyicsController: UIViewController, UITextFieldDelegate {

    let bounds = UIScreen.main.bounds
    
    var spriteScene: VIRPScene!
    
    @IBOutlet var spriteView: SKView!
    
    var visibleRect: CGRect!
    
    var drew = false
    var viewHasLoaded = false
    
    var voltageValue: Float = 10
    var currentValue: Float = 1
    var resistanceValue: Float = 10
    var powerValue: Float = 10

    @IBOutlet var voltageSlider: UISlider!
    @IBOutlet var currentSlider: UISlider!
    @IBOutlet var resistanceSlider: UISlider!
    
    @IBOutlet var voltageField: UITextField!
    @IBOutlet var currentField: UITextField!
    @IBOutlet var resistanceField: UITextField!
    
    var resistanceRatio: CGFloat {
        get {
            return CGFloat(resistanceSlider.value / (0.5 * resistanceSlider.maximumValue))
        }
    }
    
    @IBOutlet var powerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Circuit ⚡️⚡️"
        /*
        let btn = UIButton(type: UIButtonType.InfoLight)
        btn.addTarget(self, action: #selector(CannonPhsyicsController.infoPressed), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
 */
//        navigationItem.rightBarButtonItem?.target = self
//        navigationItem.rightBarButtonItem?.action = #selector(CannonPhsyicsController.infoPressed)
        
        // Do any nadditional setup after loading the view.
        
        
        spriteView.showsFPS = false
        spriteView.showsNodeCount = false
        viewHasLoaded = true
    }
    
    func infoPressed() {
        print("show them some info!")
    }
    
    
    //sliders change
    @IBAction func voltageSliderChanged(_ sender: UISlider) {
        updateVariables(sender)
    }
    
    @IBAction func currentSliderChanged(_ sender: UISlider) {
        updateVariables(sender)
    }
    
    @IBAction func resistanceSliderChanged(_ sender: UISlider) {
        //update other variables!
        updateVariables(sender)
    }
    
    //fields change
    @IBAction func voltageFieldEdited(_ sender: UITextField) {
        guard var number = Float(sender.text!) else {
            let defaultValue: Float = 5
            sender.text = "\(defaultValue)"
            voltageSlider.value = defaultValue
            updateVariables(voltageSlider)
            
            return
        }
        
        //prevent too big or too small
        if number > Float(voltageSlider.maximumValue) {
            number = Float(voltageSlider.maximumValue)
            sender.text = "\(number)"
        } else if number < Float(voltageSlider.minimumValue) {
            number = Float(voltageSlider.minimumValue)
            sender.text = "\(number)"
        }
        
        voltageSlider.value = number
        updateVariables(voltageSlider)
    }
    
    @IBAction func currentFieldChanged(_ sender: UITextField) {
        guard var number = Float(sender.text!) else {
            let defaultValue: Float = 5
            sender.text = "\(defaultValue)"
            currentSlider.value = defaultValue
            updateVariables(currentSlider)
            
            return
        }
        
        //prevent too big or too small
        if number > Float(currentSlider.maximumValue) {
            number = Float(currentSlider.maximumValue)
            sender.text = "\(number)"
        } else if number < Float(currentSlider.minimumValue) {
            number = Float(currentSlider.minimumValue)
            sender.text = "\(number)"
        }
        
        currentSlider.value = number
        updateVariables(currentSlider)
    }
    
    @IBAction func resistanceFieldChanged(_ sender: UITextField) {
        guard var number = Float(sender.text!) else {
            let defaultValue: Float = 5
            sender.text = "\(defaultValue)"
            resistanceSlider.value = defaultValue
            updateVariables(resistanceSlider)
            
            return
        }
        
        //prevent too big or too small
        if number > Float(resistanceSlider.maximumValue) {
            number = Float(resistanceSlider.maximumValue)
            sender.text = "\(number)"
        } else if number < Float(resistanceSlider.minimumValue) {
            number = Float(resistanceSlider.minimumValue)
            sender.text = "\(number)"
        }
        
        resistanceSlider.value = number
        updateVariables(resistanceSlider)
    }
    
    func updateVariables(_ slider: UISlider) {
        //one of these will change after a computation
        voltageValue = voltageSlider.value
        currentValue = currentSlider.value
        resistanceValue = resistanceSlider.value
        
        switch slider {
        case voltageSlider:
            //v changed, adapt current ONLY (weird to change resistance...)
            currentValue = voltageValue / resistanceValue
            currentSlider.value = currentValue
            spriteScene.updateCurrent(CGFloat(currentValue / 5))
            break
        case currentSlider:
            //current changed -> change resistance
            resistanceValue = voltageValue / currentValue
            resistanceSlider.value = resistanceValue
            spriteScene.updateResistorNode(resistanceRatio)
            spriteScene.updateCurrent(CGFloat(currentValue / 5))//need to cahge the 5 if u change default...
            break
        case resistanceSlider:
            //resistance changed -> change the current
            currentValue = voltageValue / resistanceValue
            currentSlider.value = currentValue
            spriteScene.updateResistorNode(resistanceRatio)
            spriteScene.updateCurrent(CGFloat(currentValue / 5))
            break
        default:
            break
        }
        
        voltageField.text = "\(voltageValue)"
        currentField.text = "\(currentValue)"
        resistanceField.text = "\(resistanceValue)"
        
        powerLabel.text = "P = \(Int(round(voltageValue * currentValue * 10) / 10)) W"
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
    
    

    
//    @IBAction func angleFieldChanged(sender: UITextField) {
//        guard var number = Float(sender.text!) else {
//            sender.text = "0"
//            angleSlider.value = 0
//            updateCannonAngle()
//            
//            return
//        }
//        
//        if number > 90 {
//            number = 90
//            sender.text = "\(number)"
//        } else if number < 0 {
//            number = 0
//            sender.text = "\(number)"
//        }
//        
//        angleSlider.value = number
//        updateCannonAngle()
//    }
    

    
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !drew {
            if viewHasLoaded {
                spriteScene = VIRPScene(size: spriteView.frame.size)
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
