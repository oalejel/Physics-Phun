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

    let bounds = UIScreen.mainScreen().bounds
    
    var visibleRect: CGRect!
    
    var drew = false
    var viewLoaded = false
    
    @IBOutlet var sceneView: SCNView!
    
    var experimentScene: AirBoxScene!
    
    var volumeValue: Float = 1
    var pressureValue: Float = 1
    var temperatureValue: Float = 1
    var molesValue: Float = 1
    
    @IBOutlet var volumeSlider: UISlider!
    @IBOutlet var pressureSlider: UISlider!
    @IBOutlet var temperatureSlider: UISlider!
    @IBOutlet var molesSlider: UISlider!
    
    @IBOutlet var lockSegmentControl: UISegmentedControl!
    
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var volumeLabel: UILabel!
    @IBOutlet var molesLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Air Box 💨"
        let btn = UIButton(type: UIButtonType.InfoLight)
        btn.addTarget(self, action: #selector(CannonPhsyicsController.infoPressed), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
//        navigationItem.rightBarButtonItem?.target = self
//        navigationItem.rightBarButtonItem?.action = #selector(CannonPhsyicsController.infoPressed)
        
        // Do any additional setup after loading the view.
        
        sceneView.backgroundColor = UIColor(red: 1, green: 230/255, blue: 179/255, alpha: 1)
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        
        experimentScene = AirBoxScene()
        sceneView.scene = experimentScene
        
        pressureSlider.enabled = false
        
//        let cameraNode = SCNNode()
//        cameraNode.camera = SCNCamera()
//        cameraNode.position = SCNVector3Make(0, 0, 15)
//        experimentScene.rootNode.addChildNode(cameraNode)
        
        
        viewLoaded = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !drew {
            if viewLoaded {
                experimentScene.generateParticles(60)
                drew = true
            }
            
        } else {
            //            spriteScene.size = spriteView.frame.size
        }
    }
    
    func infoPressed() {
        print("show them some info!")
        let infoTextVC = InfoTextViewController()
//        infoTextVC.textView
        navigationController?.pushViewController(infoTextVC, animated: true)
    }

    
    @IBAction func lockSegmentChanged(sender: UISegmentedControl) {
        pressureSlider.enabled = true
        volumeSlider.enabled = true
        temperatureSlider.enabled = true
        molesSlider.enabled = true
        
        switch sender.selectedSegmentIndex {
        case 0:
            pressureSlider.enabled = false
            break
        case 1:
            volumeSlider.enabled = false
            break
        case 2:
            temperatureSlider.enabled = false
            break
        default:
            return
        }
    }
    
    @IBAction func touchUpInsideVolumeSlider(sender: UISlider) {
        experimentScene.reflectionAllowed = true
        for sphere in experimentScene.spheres {
            sphere.resumeMotion()
        }
    }
    
    @IBAction func touchBeganInVolumeSlider(sender: UISlider) {
        experimentScene.reflectionAllowed = false
        for sphere in experimentScene.spheres {
            sphere.pauseMotion()
        }
    }
    
    @IBAction func volumeSliderChanged(sender: UISlider) {
        experimentScene.reflectionAllowed = false
        //increase duration with relation to scale maybe... idk
        let scale = SCNAction.scaleTo(CGFloat(sender.value / sender.maximumValue), duration: 1.2)
        //SCNVector3Make(sender.value, sender.value, sender.value)
        experimentScene.boxNode.runAction(scale)
        
        updateVariables(sender)
    }
    
    @IBAction func pressureSliderMoved(sender: UISlider) {
        updateVariables(sender)
    }
    
    @IBAction func temperatureSliderChanged(sender: UISlider) {
        experimentScene.physicsWorld.speed = CGFloat(sender.value / 300)
        updateVariables(sender)
    }
  
    @IBAction func molesSliderChanged(sender: UISlider) {
//        print("number of spheres: \(experimentScene.spheres.count)")
        let moles = sender.value
        let numParticles = Int(moles * 20)
        let difference = numParticles - experimentScene.spheres.count
        if difference > 0 {
            experimentScene.generateParticles(difference)
        } else {
            experimentScene.removeParticles(-difference)
        }
        
        updateVariables(sender)
    }
    
    func updateVariables(slider: UISlider) {
        pressureValue = pressureSlider.value
        volumeValue = volumeSlider.value
        
        molesValue = molesSlider.value
        let R: Float = 0.0825
        temperatureValue = temperatureSlider.value
        
        print("P: \(pressureValue), V: \(volumeValue), n: \(molesValue), T: \(temperatureValue)")
        
        if slider == molesSlider  {
            pressureValue = (molesValue * R * temperatureValue) / volumeValue
            pressureSlider.value = pressureValue
            return
        } else {
            
            //! remember that n will not be influenced by other sliders
            switch lockSegmentControl.selectedSegmentIndex {
            case 0:
                //pressure is locked – only v and t will change – check if v or t slider is changed
                if slider == temperatureSlider {
                    //temp slider is what is being changed – set v slider value and label (v = (nRT / P) )
                    volumeValue = (molesValue * R * temperatureValue) / pressureValue
                    volumeSlider.value = volumeValue
                } else {
                    temperatureValue = (pressureValue * volumeValue) / (molesValue * R)
                    temperatureSlider.value = temperatureValue
                }
                break
            case 1:
                //volume locked
                if slider == temperatureSlider {
                    //temp slider is what is being changed – set  slider value and label (v = (nRT / P) )
                    pressureValue = (molesValue * R * temperatureValue) / volumeValue
                    pressureSlider.value = pressureValue
                } else {
                    temperatureValue = (pressureValue * volumeValue) / (molesValue * R)
                    temperatureSlider.value = temperatureValue
                }
                break
            case 2:
                //temperature locked
                if slider == volumeSlider {
                    //temp slider is what is being changed – set  slider value and label (v = (nRT / P) )
                    pressureValue = (molesValue * R * temperatureValue) / volumeValue
                    pressureSlider.value = pressureValue
                } else {
                    volumeValue = (molesValue * R * temperatureValue) / pressureValue
                    volumeSlider.value = volumeValue
                }
                break
            default:
                break
            }

        }
        
        //update labels
        pressureLabel.text = "P: Pressure = \(pressureValue) atm"
        volumeLabel.text = "V: Volume = \(volumeValue) m^3"
        molesLabel.text = "n: moles = \(molesValue)"
        temperatureLabel.text = "T: Temperature = \(temperatureValue) K"
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
 
    

    deinit {
        print("••••••••••••••deinit called••••••••••••")
    }
    
    

}
