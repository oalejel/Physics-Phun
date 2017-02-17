//
//  NeutronScene.swift
//  AppLab
//
//  Created by Omar Alejel on 5/20/16.
//  Copyright © 2016 omar alejel. All rights reserved.
//


/*
    Notes:
        - make sure that incresing intensity increases velocity of N and decreases generation time
 */

import UIKit
import SpriteKit
import GameplayKit

class Neutron: SKShapeNode {
    var passesFirstMedium = false
    var startVelocity: CGVector = CGVectorMake(0, 0)
}

class NeutronScene: SKScene, SKPhysicsContactDelegate {
    var donutNode: SKSpriteNode!
    
    var shooter: SKSpriteNode!
    var shootAnchor: SKSpriteNode!
    
    var detectorAnchor: SKSpriteNode!
    var detector: SKSpriteNode!
    
    var spinDownMode = false
    var netFieldExists = false
    
    var neutrons: [Neutron] = []
    
    var lastNeutronPassesFirstMedium = false
    
    let m1BitMask: UInt32 = 0b1000
    let m2BitMask: UInt32 = 0b0100
    let detectorBitMask: UInt32 = 0b1100
    
    var layer1: SKSpriteNode!
    var layer2: SKSpriteNode!
    
    var shooterAngle: CGFloat = 0
    
    var layer2Y: CGFloat = 0
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
                
        backgroundColor = UIColor(red: 1, green: 230/255, blue: 179/255, alpha: 1)
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0, 0)
        
        physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        physicsBody?.restitution = 0
        physicsBody?.collisionBitMask = 0xFFFFFF
        
        let layerY: CGFloat = 25
        
     
        //try makeing size zero
        shootAnchor = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake(10, 10))
        shootAnchor.anchorPoint = CGPointMake(0.5, 0.5)
        shootAnchor.position = CGPointMake(size.width / 2, layerY)
        
        
        detectorAnchor = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake(10, 10))
        detectorAnchor.anchorPoint = CGPointMake(0.5, 0.5)
        detectorAnchor.position = CGPointMake(size.width / 2, layerY)
        
        let shooterWidth = size.width / 3
        shooter = SKSpriteNode(color: SKColor.grayColor(), size: CGSizeMake(shooterWidth, size.width / 10))
        shooter.anchorPoint = CGPointMake(0.5, 0.5)
        let shooterLabel = SKLabelNode(text: "Emitter")
        shooterLabel.fontName = "Helvetica"
        shooterLabel.fontSize = 14
        shooterLabel.horizontalAlignmentMode = .Center
        shooterLabel.fontColor = UIColor.whiteColor()
        shooter.addChild(shooterLabel)
        
        //watch out for the height component of the atan/...
        let yComp = ((size.height / 2) - (layerY * 1.3))
        let xComp = ((size.width / 2) - (shooterWidth / 2))
        shooterAngle = -CGFloat(atan(yComp / xComp))
        shooter.zRotation = shooterAngle
        
        /////
        let detectorSize = CGSizeMake(shooterWidth, size.width / 10)
        detector = SKSpriteNode(color: SKColor.blackColor(), size: detectorSize)
        detector.anchorPoint = CGPointMake(0.5, 0.5)
        detector.physicsBody = SKPhysicsBody(rectangleOfSize: detectorSize)
        detector.physicsBody?.usesPreciseCollisionDetection = true
        detector.physicsBody?.dynamic = false
        detector.physicsBody?.collisionBitMask = detectorBitMask
        detector.physicsBody?.contactTestBitMask = detectorBitMask
        
        let detectorLabel = SKLabelNode(text: "Detector")
        detectorLabel.fontName = "Helvetica"
        detectorLabel.fontSize = 14
        detectorLabel.horizontalAlignmentMode = .Center
        detectorLabel.fontColor = UIColor.whiteColor()
        detector.addChild(detectorLabel)
        
        //watch out for the height component of the atan/...
        let detectorY = ((size.height / 2) - (layerY * 1.3))
        let detectorX = ((size.width / 2) - (shooterWidth / 2))
        let detectorAngle = CGFloat(atan(detectorY / detectorX))
        detector.zRotation = detectorAngle
        ////
        
        shooter.position = CGPointMake((-size.width / 2) + (shooter.frame.size.width / 2), (frame.size.height / 2) - ((shootAnchor.size.height / 2) + (shootAnchor.position.y)))
        
        detector.position = CGPointMake((size.width / 2) - (detector.frame.size.width / 2), (frame.size.height / 2) - ((detectorAnchor.size.height / 2) + (detectorAnchor.position.y)))
        //(shooterWidth / 2) - ((size.width / 2) + (shootAnchor.size.width / 2))
        
        
        addChild(shootAnchor)
        addChild(detectorAnchor)
        shootAnchor.addChild(shooter)
        detectorAnchor.addChild(detector)
        
        
        let graph = SKSpriteNode(imageNamed: "graph")
        graph.anchorPoint = CGPointMake(0.5, 0.5)
        graph.position = CGPointMake(size.width / 2, (size.height) - ((graph.size.height / 2) + 14))
        addChild(graph)

        
//        addChild(shooter)
        
        let mediumSize = CGSizeMake(size.width / 2, 2)
        
        layer1 = SKSpriteNode(color: UIColor.blackColor(), size: mediumSize)
        layer1.anchorPoint = CGPointMake(0.5, 0)
        layer1.position = CGPointMake(size.width / 2, layerY)
        layer1.physicsBody = SKPhysicsBody(rectangleOfSize: mediumSize)
        layer1.physicsBody?.usesPreciseCollisionDetection = true
        layer1.physicsBody?.collisionBitMask = m1BitMask
        layer1.physicsBody?.categoryBitMask = m1BitMask
        layer1.physicsBody?.contactTestBitMask = m1BitMask
        layer1.physicsBody?.dynamic = false
        addChild(layer1)
        
        layer2 = SKSpriteNode(color: UIColor.blackColor(), size: mediumSize)
        layer2.anchorPoint = CGPointMake(0.5, 0)
        layer2.position = CGPointMake(size.width / 2, layerY * (3/4))
        layer2Y = layer2.position.y
        layer2.physicsBody = SKPhysicsBody(rectangleOfSize: mediumSize)
        layer2.physicsBody?.usesPreciseCollisionDetection = true
        layer2.physicsBody?.collisionBitMask = m2BitMask
        layer2.physicsBody?.categoryBitMask = m2BitMask
        layer2.physicsBody?.contactTestBitMask = m2BitMask
        layer2.physicsBody?.dynamic = false
        addChild(layer2)
    }
    
    func startNeutronBeam(intensity: Double) {
        removeActionForKey("beam")
        
        let delay = SKAction.waitForDuration(1 / intensity)
        let block = SKAction.runBlock {
            let relativeAngle = self.shootAnchor.zRotation + self.shooterAngle
            
            let neutron = Neutron(circleOfRadius: 2)
            
            neutron.fillColor = self.spinDownMode ? SKColor.blueColor() : SKColor.redColor()
            neutron.strokeColor = self.spinDownMode ? SKColor.blueColor() : SKColor.redColor()
            neutron.position = self.convertPoint(self.shooter.position, fromNode: self.shootAnchor)//CGPointMake(self.shooter.position.x + self.shootAnchor.position.x, self.shooter.position.y + self.shootAnchor.position.y + 10)
            
            
            
            neutron.physicsBody = SKPhysicsBody(circleOfRadius: 2)
            neutron.physicsBody?.affectedByGravity = false
            neutron.physicsBody?.usesPreciseCollisionDetection = true
            neutron.zPosition = -1
            
            //switch medium passing
            self.lastNeutronPassesFirstMedium = !self.lastNeutronPassesFirstMedium
            neutron.passesFirstMedium = self.lastNeutronPassesFirstMedium
            
            neutron.physicsBody?.collisionBitMask = neutron.passesFirstMedium ? self.m1BitMask : self.m2BitMask
            neutron.physicsBody?.categoryBitMask = neutron.passesFirstMedium ? self.m1BitMask : self.m2BitMask
            
            //for now
            let speed: CGFloat = 100
            
            let v = CGVector(dx: speed * cos(relativeAngle), dy: speed * sin(relativeAngle))

            neutron.physicsBody?.velocity = v
            neutron.startVelocity = v
            
            self.addChild(neutron)
        }
        
        let seq = SKAction.sequence([block, delay])
        runAction(SKAction.repeatActionForever(seq), withKey: "beam")
    }
    
    
    func updateAngle(angle: Float) {
        let rotate = SKAction.rotateToAngle(CGFloat(angle), duration: 0.2)
        shootAnchor.runAction(rotate)
        
        let detectorRotate = SKAction.rotateToAngle(CGFloat(-angle), duration: 0.2)
        detectorAnchor.runAction(detectorRotate)
    }
    
    
    func shootNeutron() {
        
    }

    
    override func didSimulatePhysics() {
        
    }
    
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        let a = contact.bodyA
        let b = contact.bodyB
        var set: Set<SKPhysicsBody> = [a, b]
        if set.contains(detector.physicsBody!) {
            print("neutron hit detector")
            set.remove(detector.physicsBody!)
            if let n = set.first?.node as? Neutron {
                n.removeFromParent()
            }
        } else if set.contains(layer1.physicsBody!) || set.contains(layer2.physicsBody!) {
            set.remove(layer1.physicsBody!)
            set.remove(layer2.physicsBody!)
            if let n = set.first?.node as? Neutron {
                //cjange this if you want it to be more realistic with scattering!!!
                n.physicsBody?.velocity = CGVector(dx: n.startVelocity.dx, dy: -n.startVelocity.dy)
                
                var spinFlip = false
                if self.netFieldExists {
                    if self.spinDownMode {
                        spinFlip = true
                        //temporarily flip this until the next few lines
                        self.spinDownMode = !self.spinDownMode
                    }
                }
                
                n.fillColor = self.spinDownMode ? SKColor.blueColor() : SKColor.redColor()
                n.strokeColor = self.spinDownMode ? SKColor.blueColor() : SKColor.redColor()
                
                if spinFlip {self.spinDownMode = !self.spinDownMode}
            }
        }
    }
    
    
    override func willMoveFromView(view: SKView) {
        super.willMoveFromView(view)
        removeAllChildren()
        removeAllActions()
    }
    
    
}
