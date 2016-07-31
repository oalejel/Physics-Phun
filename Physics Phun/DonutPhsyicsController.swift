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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "The Flying Donut 🍩"
        let btn = UIButton(type: UIButtonType.InfoLight)
        btn.addTarget(self, action: #selector(CannonPhsyicsController.infoPressed), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
//        navigationItem.rightBarButtonItem?.target = self
//        navigationItem.rightBarButtonItem?.action = #selector(CannonPhsyicsController.infoPressed)
        
        // Do any additional setup after loading the view.
        
        controlView.layer.cornerRadius = 10
        controlView.clipsToBounds = true
        
        spriteView.showsFPS = true
        spriteView.showsNodeCount = true
        viewLoaded = true
        
        controlView.directionDelegate = self
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
                drew = true
            }
            
        } else {
            spriteScene.size = spriteView.frame.size
        }
    }
    
    
    

}
