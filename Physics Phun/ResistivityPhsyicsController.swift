//
//  ResistivityPhsyicsController.swift
//  AppLab
//
//  Created by Omar Alejel on 5/15/16.
//  Copyright © 2016 omar alejel. All rights reserved.
//

import UIKit
import SceneKit

class ResistivityPhsyicsController: UIViewController, UITextFieldDelegate {

    let bounds = UIScreen.main.bounds
    
    var visibleRect: CGRect!
    
    var drew = false
    var viewHasLoaded = false
    
    @IBOutlet var sceneView: SCNView!
    
    var experimentScene: ResistivityScene!
    
    
    var rohValue: Float = 1
    var lengthValue: Float = 1
    var areaValue: Float = 1
    
    @IBOutlet var resistanceLabel: UILabel!
    
    @IBOutlet var lengthLabel: UILabel!
    
    @IBOutlet var resistivityLabel: UILabel!
    
    @IBOutlet var areaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Resistance 🚰"
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
        
        
        experimentScene = ResistivityScene()
        sceneView.scene = experimentScene
        
//        let cameraNode = SCNNode()
//        cameraNode.camera = SCNCamera()
//        cameraNode.position = SCNVector3Make(0, 0, 15)
//        experimentScene.rootNode.addChildNode(cameraNode)
        
        
        viewHasLoaded = true
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !drew {
            if viewHasLoaded {
                
                //                spriteScene = ResistivityScene(size: spriteView.frame.size)
                //                spriteScene.backgroundColor = UIColor.whiteColor()
                //                spriteScene.scaleMode = .AspectFit
                //                spriteView.presentScene(spriteScene)
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
 
    

    @IBAction func resistivitySliderMoved(_ sender: UISlider) {
        rohValue = sender.value
        experimentScene.rohTextNode.runAction(SCNAction.scale(to: CGFloat(rohValue), duration: 0.1))
        resistivityLabel.text = "ρ: Resistivity [Ωm] = \(Float(round(sender.value * 100)) / 100) Ωm"
        updateResistanceAndWire()
    }
    
    @IBAction func lengthSliderMoved(_ sender: UISlider) {
        lengthValue = sender.value
        experimentScene.lengthTextNode.runAction(SCNAction.scale(to: CGFloat(lengthValue), duration: 0.1))
        lengthLabel.text = "L: Length [m] = \(Float(round(sender.value * 100)) / 100) m"
        updateResistanceAndWire()
    }

    @IBAction func areaSliderMoved(_ sender: UISlider) {
        areaValue = sender.value
        experimentScene.areaTextNode.runAction(SCNAction.scale(to: CGFloat(areaValue), duration: 0.1))
        areaLabel.text = "A: Area [m^2] = \(Float(round(sender.value * 100)) / 100) m^2"
        updateResistanceAndWire()
    }
    
    func updateResistanceAndWire() {
        let rScale = (rohValue * lengthValue) / areaValue
        experimentScene.rTextNode.runAction(SCNAction.scale(to: CGFloat(rScale), duration: 0.1))
        
        experimentScene.wireNode.scale = SCNVector3Make(areaValue, lengthValue, areaValue)
        experimentScene.wireNode.opacity = CGFloat(rohValue / 3)
        resistanceLabel.text = "R: Resistance [Ω] = \(Float(round(rScale * 100)) / 100) Ω"
    }
    
    
    

}
