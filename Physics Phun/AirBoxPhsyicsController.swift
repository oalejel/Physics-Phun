//
//  AirBoxPhsyicsController.swift
//  AppLab
//
//  Created by Omar Alejel on 5/15/16.
//  Copyright © 2016 omar alejel. All rights reserved.
//

import UIKit
import SceneKit

class AirBoxPhsyicsController: UIViewController, UITextFieldDelegate {

    let bounds = UIScreen.main.bounds
    
    var visibleRect: CGRect!
    
    var drew = false
    var viewLoaded = false
    
    @IBOutlet var sceneView: SCNView!
    
    var experimentScene: AirBoxScene!
    
    var volumeValue: Double = 5
    var pressureValue: Double = 1
    var temperatureValue: Double = 1
    var molesValue: Double = 1
    
    @IBOutlet var lockSegmentControl: UISegmentedControl!
    
//    @IBOutlet var pressureLabel: UILabel!
//    @IBOutlet var volumeLabel: UILabel!
//    @IBOutlet var molesLabel: UILabel!
//    @IBOutlet var temperatureLabel: UILabel!
    
    @IBOutlet var pressureTextField: UITextField!
    @IBOutlet var volumeTextField: UITextField!
    @IBOutlet var molesTextField: UITextField!
    @IBOutlet var temperatureTextField: UITextField!
    
    @IBOutlet var pressureStepper: UIStepper!
    @IBOutlet var volumeStepper: UIStepper!
    @IBOutlet var molesStepper: UIStepper!
    @IBOutlet var temperatureStepper: UIStepper!
    
    var speedRatio: CGFloat {
        get {
            return CGFloat(pow(temperatureStepper.value / 400, 1.7)) + 0.25
        }
    }
    
    var redRatio: CGFloat {
        get {
            return CGFloat(pressureStepper.value / pressureStepper.maximumValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Air Box 💨"
        
/*
        let btn = UIButton(type: UIButtonType.InfoLight)
        btn.addTarget(self, action: #selector(CannonPhsyicsController.infoPressed), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
 */
        
//        navigationItem.rightBarButtonItem?.target = self
//        navigationItem.rightBarButtonItem?.action = #selector(CannonPhsyicsController.infoPressed)
        
        // Do any additional setup after loading the view.
        
        sceneView.backgroundColor = UIColor(red: 1, green: 230/255, blue: 179/255, alpha: 1)
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        
        
        experimentScene = AirBoxScene()
        sceneView.scene = experimentScene
        
        
        pressureTextField.delegate = self
        volumeTextField.delegate = self
        molesTextField.delegate = self
        temperatureTextField.delegate = self
        
       /// pressureSlider.enabled = false
        
//        let cameraNode = SCNNode()
//        cameraNode.camera = SCNCamera()
//        cameraNode.position = SCNVector3Make(0, 0, 15)
//        experimentScene.rootNode.addChildNode(cameraNode)
        lockSegmentChanged(lockSegmentControl)
        
        viewLoaded = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !drew {
            if viewLoaded {
                experimentScene.boxNode.scale = SCNVector3Make(0.5, 0.5, 0.5)
                experimentScene.updateSphereTemperature(speedRatio)
                experimentScene.generateParticles(Int(pow(molesStepper.value * 20, 1.2)), redRatio: redRatio)
                //initial call to disable certain steppers
                
                drew = true
            }
        } else {
            //            spriteScene.size = spriteView.frame.size
        }
    }
    
    func infoPressed() {
        print("show them some info!")
        let infoTextVC = InfoTextViewController()
        infoTextVC.textViewString = "Let's learn about the Ideal Gas Law!\n This law teachs \t things..."
        navigationController?.pushViewController(infoTextVC, animated: true)
    }

    
    @IBAction func lockSegmentChanged(_ sender: UISegmentedControl) {
        pressureStepper.isEnabled = true
        pressureTextField.isEnabled = true
        pressureStepper.alpha = 1
        pressureTextField.alpha = 1
        
        volumeStepper.isEnabled = true
        volumeTextField.isEnabled = true
        volumeStepper.alpha = 1
        volumeTextField.alpha = 1
        
        temperatureStepper.isEnabled = true
        temperatureTextField.isEnabled = true
        temperatureStepper.alpha = 1
        temperatureTextField.alpha = 1
        
        molesStepper.isEnabled = true
        molesTextField.isEnabled = true
        molesStepper.alpha = 1
        molesTextField.alpha = 1
        
        switch sender.selectedSegmentIndex {
        case 0:
            pressureStepper.isEnabled = false
            pressureTextField.isEnabled = false
            pressureStepper.alpha = 0.6
            pressureTextField.alpha = 0.6
            break
        case 1:
            volumeStepper.isEnabled = false
            volumeTextField.isEnabled = false
            volumeStepper.alpha = 0.6
            volumeTextField.alpha = 0.6
            break
        case 2:
            temperatureStepper.isEnabled = false
            temperatureTextField.isEnabled = false
            temperatureStepper.alpha = 0.6
            temperatureTextField.alpha = 0.6
            break
        default:
            return
        }
    }
    
    @IBAction func pressureFieldEndedEditing(_ sender: UITextField) {
        guard var number = Float(sender.text!) else {
            let defaultValue = (pressureStepper.maximumValue + pressureStepper.minimumValue) / 2
            sender.text = "\(defaultValue)"
            pressureStepper.value = defaultValue
            updateVariables(pressureStepper)
            
            return
        }
        
        //prevent too big or too small
        if number > Float(pressureStepper.maximumValue) {
            number = Float(pressureStepper.maximumValue)
            sender.text = "\(number)"
        } else if number < Float(pressureStepper.minimumValue) {
            number = Float(pressureStepper.minimumValue)
            sender.text = "\(number)"
        }
        
        pressureStepper.value = Double(number)
        updateVariables(pressureStepper)
    }
    
    @IBAction func volumeFieldEndedEditing(_ sender: UITextField) {
        guard var number = Float(sender.text!) else {
            let defaultValue = (volumeStepper.maximumValue + volumeStepper.minimumValue) / 2
            sender.text = "\(defaultValue)"
            volumeStepper.value = defaultValue
            updateVariables(volumeStepper)
            
            return
        }
        
        //prevent too big or too small
        if number > Float(volumeStepper.maximumValue) {
            number = Float(volumeStepper.maximumValue)
            sender.text = "\(number)"
        } else if number < Float(volumeStepper.minimumValue) {
            number = Float(volumeStepper.minimumValue)
            sender.text = "\(number)"
        }
        
        volumeStepper.value = Double(number)
        updateVariables(volumeStepper)
    }
    
    @IBAction func molesFieldEndedEditing(_ sender: UITextField) {
        guard var number = Float(sender.text!) else {
            let defaultValue = (molesStepper.maximumValue + molesStepper.minimumValue) / 2
            sender.text = "\(defaultValue)"
            molesStepper.value = defaultValue
            updateVariables(molesStepper)
            
            return
        }
        
        //prevent too big or too small
        if number > Float(molesStepper.maximumValue) {
            number = Float(molesStepper.maximumValue)
            sender.text = "\(number)"
        } else if number < Float(molesStepper.minimumValue) {
            number = Float(molesStepper.minimumValue)
            sender.text = "\(number)"
        }
        
        molesStepper.value = Double(number)
        updateVariables(molesStepper)
    }
    
    @IBAction func temperatureFieldEndedEditing(_ sender: UITextField) {
        guard var number = Float(sender.text!) else {
            let defaultValue = (temperatureStepper.maximumValue + temperatureStepper.minimumValue) / 2
            sender.text = "\(defaultValue)"
            temperatureStepper.value = defaultValue
            updateVariables(temperatureStepper)
            
            return
        }
        
        //prevent too big or too small
        if number > Float(temperatureStepper.maximumValue) {
            number = Float(temperatureStepper.maximumValue)
            sender.text = "\(number)"
        } else if number < Float(temperatureStepper.minimumValue) {
            number = Float(temperatureStepper.minimumValue)
            sender.text = "\(number)"
        }
        
        temperatureStepper.value = Double(number)
        updateVariables(temperatureStepper)
    }
    
    
    //take the value (which should be in the limit) and send it
    @IBAction func pressureStepperChanged(_ sender: UIStepper) {
        updateVariables(sender)
    }
    
    @IBAction func volumeStepperChanged(_ sender: UIStepper) {
        updateVariables(sender)
    }
    
    @IBAction func molesStepperChanged(_ sender: UIStepper) {
        updateVariables(sender)
    }
    
    @IBAction func temperatureStepperChanged(_ sender: UIStepper) {
        updateVariables(sender)
    }
    
    func updateVariables(_ stepper: UIStepper) {
        pressureValue = pressureStepper.value
        volumeValue = volumeStepper.value
        molesValue = molesStepper.value
        let R: Double = 0.0825
        temperatureValue = temperatureStepper.value
        
        print("P: \(pressureValue), V: \(volumeValue), n: \(molesValue), T: \(temperatureValue)")
        
        if stepper == molesStepper  {
            //mols only influence pressure in this simulation
            pressureValue = (molesValue * R * temperatureValue) / volumeValue
            pressureStepper.value = pressureValue
            experimentScene.updateSpherePressure(redRatio)
            
            let moles = molesStepper.value
            let numParticles = Int(pow(moles * 20, 1.1))
            let difference = numParticles - experimentScene.spheres.count
            if difference > 0 {
                experimentScene.generateParticles(difference, redRatio: redRatio)
            } else {
                experimentScene.removeParticles(-difference)
            }
        } else {
            //! remember that n will not be influenced by other sliders
            switch lockSegmentControl.selectedSegmentIndex {
            case 0:
                //pressure is locked – only v and t will change – check if v or t slider is changed
                if stepper == temperatureStepper {
                    //temp slider is what is being changed – set v slider value and label (v = (nRT / P) )
                    if ((molesValue * R * temperatureValue) / pressureValue) < volumeStepper.maximumValue {
                        volumeValue = (molesValue * R * temperatureValue) / pressureValue
                        volumeStepper.value = volumeValue
                        experimentScene.updateSphereTemperature(speedRatio)
                        setSceneVolume(CGFloat(volumeValue / volumeStepper.maximumValue))
                    } else {
                        //return temp to old
                        temperatureStepper.value = (pressureValue * volumeValue) / (molesValue * R)
                        return
                    }
                } else {
                    //dont forget to update volume when volume is directly changed....
                    temperatureValue = (pressureValue * volumeValue) / (molesValue * R)
                    temperatureStepper.value = temperatureValue
                    experimentScene.updateSphereTemperature(speedRatio)
                    experimentScene.updateSpherePressure(redRatio)
                    setSceneVolume(CGFloat(volumeValue / volumeStepper.maximumValue))
                }
                break
            case 1:
                //volume locked
                if stepper == temperatureStepper {
                    //temp slider is what is being changed – set  slider value and label (v = (nRT / P) )
                    pressureValue = (molesValue * R * temperatureValue) / volumeValue
                    pressureStepper.value = pressureValue
                    experimentScene.updateSphereTemperature(speedRatio)
                    experimentScene.updateSpherePressure(redRatio)
                } else {
                    temperatureValue = (pressureValue * volumeValue) / (molesValue * R)
                    temperatureStepper.value = temperatureValue
                    experimentScene.updateSphereTemperature(speedRatio)
                    experimentScene.updateSpherePressure(redRatio)
                }
                break
            case 2:
                //temperature locked
                if stepper == volumeStepper {
                    //volime slider is what is being changed – set  slider value and label (v = (nRT / P) )
                    pressureValue = (molesValue * R * temperatureValue) / volumeValue
                    pressureStepper.value = pressureValue
                    setSceneVolume(CGFloat(volumeValue / volumeStepper.maximumValue))
                    experimentScene.updateSpherePressure(redRatio)
                } else {
                    if ((molesValue * R * temperatureValue) / pressureValue) < volumeStepper.maximumValue {
                        volumeValue = (molesValue * R * temperatureValue) / pressureValue
                        volumeStepper.value = volumeValue
                        setSceneVolume(CGFloat(volumeValue / volumeStepper.maximumValue))
                        experimentScene.updateSpherePressure(redRatio)
                    } else {
                        //return pressure to old
                        pressureStepper.value = (molesValue * R * temperatureValue) / volumeValue
                        return
                    }
                }
                break
            default:
                break
            }
            
        }
        
        //update labels
        pressureTextField.text = "\(pressureValue)"
        volumeTextField.text = "\(volumeValue)"
        molesTextField.text = "\(molesValue)"
        temperatureTextField.text = "\(temperatureValue)"
    }
    
    
    //called when either textfield or stepper pressed – update other values
    
//    func updatePressure(p: Double) {
//        
//    }
//    
//    func updateVolume(v: Double) {
//        
//    }
//    
//    func updateMoles(n: Double) {
//        
//    }
//    
//    func updateTemperature(t: Double) {
//    
//    }
    
    
    func setSceneVolume(_ scale: CGFloat) {
        experimentScene.reflectionAllowed = false
        for sphere in experimentScene.spheres {
            sphere.pauseMotion()
        }
        
        let scaleAction = SCNAction.scale(to: scale, duration: 1.2)
        let resumeMotionAction = SCNAction.run { (node) in
            self.experimentScene.reflectionAllowed = true
            for sphere in self.experimentScene.spheres {
                sphere.resumeMotion()
            }
        }
        let sequence = SCNAction.sequence([scaleAction, resumeMotionAction])
        
        experimentScene.boxNode.removeAllActions()
        experimentScene.boxNode.runAction(sequence)
    }
    
//    
//    
//    ///old functions
//    @IBAction func touchUpInsideVolumeSlider(sender: UISlider) {
//        experimentScene.reflectionAllowed = true
//        for sphere in experimentScene.spheres {
//            sphere.resumeMotion()
//        }
//    }
//    
//    @IBAction func touchBeganInVolumeSlider(sender: UISlider) {
//        experimentScene.reflectionAllowed = false
//        for sphere in experimentScene.spheres {
//            sphere.pauseMotion()
//        }
//    }
//    
//    @IBAction func volumeSliderChanged(sender: UISlider) {
//        experimentScene.reflectionAllowed = false
//        //increase duration with relation to scale maybe... idk
//        let scale = SCNAction.scaleTo(CGFloat(sender.value / sender.maximumValue), duration: 1.2)
//        //SCNVector3Make(sender.value, sender.value, sender.value)
//        experimentScene.boxNode.runAction(scale)
//        
//        updateVariables(sender)
//    }
//    
//    @IBAction func pressureSliderMoved(sender: UISlider) {
//        updateVariables(sender)
//    }
//    
//    @IBAction func temperatureSliderChanged(sender: UISlider) {
//        experimentScene.physicsWorld.speed = CGFloat(sender.value / 300)
//        updateVariables(sender)
//    }
//  
//    @IBAction func molesSliderChanged(sender: UISlider) {
////        print("number of spheres: \(experimentScene.spheres.count)")
//        let moles = sender.value
//        let numParticles = Int(moles * 20)
//        let difference = numParticles - experimentScene.spheres.count
//        if difference > 0 {
//            experimentScene.generateParticles(difference)
//        } else {
//            experimentScene.removeParticles(-difference)
//        }
//        
//        updateVariables(sender)
//    }
    

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
 
    

    deinit {
        print("••••••••••••••deinit called••••••••••••")
    }
    
    

}
