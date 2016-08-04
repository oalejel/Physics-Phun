//
//  DonutScene.swift
//  AppLab
//
//  Created by Omar Alejel on 5/20/16.
//  Copyright © 2016 omar alejel. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class DonutScene: SKScene, SKPhysicsContactDelegate {
    var donutNode: SKSpriteNode!
    var emitter: SKEmitterNode!
    
    var didDraw = false
    
//    var framesAfterLaunch = 0
    
//    let degreesToRadians = Float(M_PI / 180)
    
    func pushDonut(p: CGPoint) {
            donutNode.removeActionForKey("push")
            let applyForce = SKAction.applyForce(CGVector(dx: 20 * p.x, dy: 20 * p.y), duration: 200)
            donutNode.runAction(applyForce, withKey: "push")
            
            let power = sqrt(pow(p.x, 2) + pow(p.y, 2))
            emitter.particleBirthRate = power
            
            var theta = atan(p.y / p.x) + CGFloat(M_PI)
            if p.y < 0 && p.x < 0 {
                theta = theta + CGFloat(M_PI)
            } else if p.x < 0 && p.y > 0 {
                theta = theta + CGFloat(M_PI)
            }
            
            print(theta
            
            )
            
            emitter.emissionAngle = theta
//            emitter.particlePositionRange = CGVectorMake(0, power)
//            emitter
           
    }
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        if !didDraw {
            didDraw = true
            
            backgroundColor = UIColor(red: 1, green: 230/255, blue: 179/255, alpha: 1)
            
            physicsWorld.contactDelegate = self
            physicsWorld.gravity = CGVectorMake(0, 0)
            
            physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            physicsBody?.restitution = 0
            physicsBody?.contactTestBitMask = 0x00F0
            
            
            
            let texture = SKTexture(imageNamed: "donut")
            donutNode = SKSpriteNode(texture: texture)//imageNamed: "donut")
            
            donutNode.anchorPoint = CGPointMake(0.5, 0.5)
            donutNode.position = view.center
            
            donutNode.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
            donutNode.physicsBody?.contactTestBitMask = 0x000F
            donutNode.physicsBody?.dynamic = true
            donutNode.physicsBody?.affectedByGravity = false
            donutNode.physicsBody?.mass = 10
            donutNode.physicsBody?.usesPreciseCollisionDetection = true
            donutNode.physicsBody?.allowsRotation = false
            addChild(donutNode)
            
            emitter = SKEmitterNode(fileNamed: "FireParticle")
            //        emitter.emissionAngleRange = CGFloat(M_PI / 4)
            emitter.zPosition = -1
            emitter.particleBirthRate = 0.0001
            donutNode.addChild(emitter)
        }
                
    }
    
   
    

    override func willMoveFromView(view: SKView) {
        super.willMoveFromView(view)
        removeAllChildren()
        removeAllActions()
    }

    
    override func didSimulatePhysics() {
        print(donutNode.physicsBody?.velocity)
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
    }
    
    
    
    
    
}
