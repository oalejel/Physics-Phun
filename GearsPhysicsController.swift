//
//  GearsPhysicsController.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 2/24/17.
//  Copyright © 2017 omaralejel. All rights reserved.
//

import UIKit
import SpriteKit

class GearsPhysicsController: UIViewController {
    
    let bounds = UIScreen.main.bounds
    
    var spriteScene: GearsScene!
    
    var drew = false
    var viewHasLoaded = false
    
    @IBOutlet var spriteView: SKView!
    
    @IBOutlet weak var largeGear1Button: UIButton!
    @IBOutlet weak var mediumGear1Button: UIButton!
    @IBOutlet weak var smallGear1Button: UIButton!
    @IBOutlet weak var largeGear2Button: UIButton!
    @IBOutlet weak var mediumGear2Button: UIButton!
    @IBOutlet weak var smallGear2Button: UIButton!
    
    var selectedGearButton1: UIButton!
    var selectedGearButton2: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Gears ⚙️"
        
        selectedGearButton1 = largeGear1Button
        selectedGearButton2 = mediumGear2Button
        
        largeGear1Button.imageView?.layer.shadowColor = UIColor.yellow.cgColor
        largeGear1Button.imageView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        largeGear1Button.imageView?.layer.shadowRadius = 5
        largeGear1Button.imageView?.layer.shadowOpacity = 0.3
        largeGear1Button.imageView?.clipsToBounds = false
        
        hightlightGear(button: largeGear1Button)
        hightlightGear(button: mediumGear2Button)
        
        viewHasLoaded = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !drew {
            if viewHasLoaded {
                spriteScene = GearsScene(size: spriteView.frame.size)
                spriteScene.backgroundColor = UIColor.white
                spriteScene.scaleMode = .aspectFit
                spriteView.presentScene(spriteScene)
                drew = true
                

                
//                let accelerationLabel = UILabel()
//                accelerationLabel.text = "Acceleration"
//                
//                accelerationLabel.textColor = UIColor.blue
//                accelerationLabel.font = UIFont(name: "Helvetica", size: 10)
//                view.addSubview(accelerationLabel)
//                accelerationLabel.sizeToFit()
//                accelerationLabel.center = accelerationChart.center
                
            }
        } else {
            spriteScene.size = spriteView.frame.size
        }
    }

    @IBAction func gearPressed(_ sender: UIButton) {
        
        
        switch sender {
        case largeGear1Button:
            unhighlightGear(button: selectedGearButton1)
            selectedGearButton1 = sender
            break
        case mediumGear1Button:
            unhighlightGear(button: selectedGearButton1)
            selectedGearButton1 = sender
            break
        case smallGear1Button:
            unhighlightGear(button: selectedGearButton1)
            selectedGearButton1 = sender
            break
        case largeGear2Button:
            unhighlightGear(button: selectedGearButton2)
            selectedGearButton2 = sender
            break
        case mediumGear2Button:
            unhighlightGear(button: selectedGearButton2)
            selectedGearButton2 = sender
            break
        case smallGear2Button:
            unhighlightGear(button: selectedGearButton2)
            selectedGearButton2 = sender
            break
        default:
            break
        }
        
        hightlightGear(button: sender)
        
    }
    
    func hightlightGear(button: UIButton) {
        button.imageView?.layer.shadowColor = UIColor.yellow.cgColor
        button.imageView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.imageView?.layer.shadowRadius = 5
        button.imageView?.layer.shadowOpacity = 0.3
        button.imageView?.clipsToBounds = false
    }
    
    func unhighlightGear(button: UIButton) {
//        button.imageView?.layer.shadowColor = UIColor.yellow.cgColor
//        button.imageView?.layer.shadowOffset = CGSize(width: 0, height: 0)
//        button.imageView?.layer.shadowRadius = 5
        button.imageView?.layer.shadowOpacity = 0
//        button.imageView?.clipsToBounds = false
    }
    
    
    

}
