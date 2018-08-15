//
//  GearsScene.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 4/4/17.
//  Copyright © 2017 omaralejel. All rights reserved.
//

import UIKit
import SpriteKit

public enum GearSize: Int {
    case large = 16
    case medium = 10
    case small = 6
}

class GearNode: SKSpriteNode {
    var _gearSize: GearSize = .large
}

class GearsScene: ExperimentScene {
    
    var gear1Node: GearNode!
    var gear2Node: GearNode!
    
    var didDraw = false
    
    private let toothLength: CGFloat = 4
    private let largeGearOffset: CGFloat = 20

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        if !didDraw {
            didDraw = true
            
            backgroundColor = UIColor(red: 1, green: 230/255, blue: 179/255, alpha: 1)
            
            gear1Node = newGear(size: .large, row: 1)
            addChild(gear1Node)
            gear2Node = newGear(size: .medium, row: 2)
            addChild(gear2Node)
            
            let duration: TimeInterval = 2
            let rotate1 = SKAction.rotate(byAngle: CGFloat(Double.pi * 2), duration: duration)
            let repeatRotate1 = SKAction.repeatForever(rotate1)
            let ratio = 10.0 / 16.0
            let rotate2 = SKAction.rotate(byAngle: CGFloat(Double.pi * -2), duration: duration * ratio)
            let repeatRotate2 = SKAction.repeatForever(rotate2)
            
            gear1Node.run(repeatRotate1)
            gear2Node.run(repeatRotate2)
        }
    }
    
    override func willMove(from view: SKView) {
        super.willMove(from: view)
        removeAllChildren()
        removeAllActions()
    }
    
    func newGear(size: GearSize, row: Int) -> GearNode {
        
        
        let largeGearSize = CGSize(width: frame.size.height - 20, height: frame.size.height - 20)
        
        var node: GearNode!
        switch size {
        case .large:
            node = GearNode(imageNamed: "large_gear")
            node.size = CGSize(width: largeGearSize.width, height: largeGearSize.width)
            node.zRotation = row == 1 ? 0 : 0.172142
        case .medium:
            node = GearNode(imageNamed: "medium_gear")
            node.size = CGSize(width: largeGearSize.width * 0.6592, height: largeGearSize.width * 0.6592)
            node.zRotation = row == 1 ? 0.3098 : -0.03442
        case .small:
            node = GearNode(imageNamed: "small_gear")
            node.size = CGSize(width: largeGearSize.width * 0.4347, height: largeGearSize.width * 0.4347)
            node.zRotation = row == 1 ? 0.556 : -0.03442
        }
        
        node._gearSize = size

        let multiplier: CGFloat = row == 1 ? -1 : 1
        node.position = CGPoint(x: (view!.frame.size.width / 2) + (multiplier * (node.size.width / 2)) + (-1 * multiplier * toothLength), y: frame.size.height / 2)
        return node
    }
    
    func setGear1(gearSize: GearSize) {
        gear1Node.removeAllActions()
        gear1Node.removeFromParent()
        gear1Node = newGear(size: gearSize, row: 1)
        addChild(gear1Node)
        

    }
    
    func setGear2(gearSize: GearSize) {
        gear2Node.removeAllActions()
        gear2Node.removeFromParent()
        gear2Node = newGear(size: gearSize, row: 2)
        addChild(gear2Node)
    }
    
    //consider creating an action group that readjusts the z rotation so that small errors in the rotation action do not end up with incorrect positions after a long time..
    func setGear1RPS(rps: Double) {
        gear1Node.removeAllActions()
        switch gear1Node._gearSize {
        case .large:
            gear1Node.zRotation = 0
        case .medium:
            gear1Node.zRotation = 0.3098
        case .small:
            gear1Node.zRotation = 0.556
        }
        
        let duration: TimeInterval = 1 / rps
        let rotate1 = SKAction.rotate(byAngle: CGFloat(Double.pi * 2), duration: duration)
        let repeatRotate1 = SKAction.repeatForever(rotate1)
        
        gear1Node.run(repeatRotate1)
    }
    
    func setGear2RPS(rps: Double) {
        gear2Node.removeAllActions()
        switch gear2Node._gearSize {
        case .large:
            gear2Node.zRotation = 0.172142
        case .medium:
            gear2Node.zRotation = -0.03442
        case .small:
            gear2Node.zRotation = -0.03442
        }
        
        let duration: TimeInterval = 1 / rps
        let rotate2 = SKAction.rotate(byAngle: CGFloat(Double.pi * -2), duration: duration)
        let repeatRotate2 = SKAction.repeatForever(rotate2)
        
        gear2Node.run(repeatRotate2)
    }
    
    
}
