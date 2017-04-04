//
//  GearsScene.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 4/4/17.
//  Copyright © 2017 omaralejel. All rights reserved.
//

import UIKit
import SpriteKit

enum GearSize {
    case large, medium, small
}

class GearsScene: SKScene {
    
    var gear1Node: SKSpriteNode!
    var gear2Node: SKSpriteNode!
    
    var didDraw = false
    
    let largeGearOffset: CGFloat = 20
    
    var sizes: [GearSize:CGSize] = [.large:CGSize.zero, .medium:CGSize.zero, .small:CGSize.zero]

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        if !didDraw {
            didDraw = true
            
            backgroundColor = UIColor(red: 1, green: 230/255, blue: 179/255, alpha: 1)
            
            
            
            addChild(gearNode)
            addChild(gearNode2)
            addChild(gearNode3)



        }
    }
    
    
    override func willMove(from view: SKView) {
        super.willMove(from: view)
        removeAllChildren()
        removeAllActions()
    }
    
    func newGear(size: GearsScene, row: Int) {
        
        
        if row == 1 {
        
        } else {
            
        }
    }
    
    func setGear1(gearSize: GearSize) {
    }
    
    func setGear2(gearSize: GearSize) {
        
    }
    
    
}
