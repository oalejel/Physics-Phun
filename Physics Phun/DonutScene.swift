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
    
    weak var donutController: DonutPhsyicsController!
    
    var pastAccelerations: [CGFloat] = [0.0] {
        didSet {
            if pastAccelerations.count > 60 {
                pastAccelerations.removeFirst()
            }
            donutController.accelerationChart.clear()
            donutController.accelerationChart.addLine(pastAccelerations)
        }
    }
    
    var pastVelocities: [CGFloat] = [0.0] {
        didSet {
            if pastVelocities.count > 60 {
                pastVelocities.removeFirst()
            }
            donutController.velocityChart.clear()
            donutController.velocityChart.addLine(pastVelocities)
        }
    }
    
//    var framesAfterLaunch = 0
    
//    let degreesToRadians = Float(M_PI / 180)
    
    func pushDonut(_ p: CGPoint) {
            donutNode.removeAction(forKey: "push")
            let applyForce = SKAction.applyForce(CGVector(dx: 20 * p.x, dy: 20 * p.y), duration: 200)
            pastAccelerations.append(sqrt(pow(p.x, 2) + pow(p.y, 2)))
            donutNode.run(applyForce, withKey: "push")
            
            let power = sqrt(pow(p.x, 2) + pow(p.y, 2))
            emitter.particleBirthRate = power
            
            var theta = atan(p.y / p.x) + CGFloat(M_PI)
            if p.y < 0 && p.x < 0 {
                theta = theta + CGFloat(M_PI)
            } else if p.x < 0 && p.y > 0 {
                theta = theta + CGFloat(M_PI)
            }
            
            print(theta)
            
            emitter.emissionAngle = theta
//            emitter.particlePositionRange = CGVectorMake(0, power)
//            emitter
           
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        if !didDraw {
            didDraw = true
            
            backgroundColor = UIColor(red: 1, green: 230/255, blue: 179/255, alpha: 1)
            
            physicsWorld.contactDelegate = self
            physicsWorld.gravity = CGVector(dx: 0, dy: 0)
            
            physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            physicsBody?.restitution = 0
            physicsBody?.contactTestBitMask = 0x00F0
            
            
            
            let texture = SKTexture(imageNamed: "donut")
            donutNode = SKSpriteNode(texture: texture)//imageNamed: "donut")
            
            donutNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            donutNode.position = view.center
            
            donutNode.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
            donutNode.physicsBody?.contactTestBitMask = 0x000F
            donutNode.physicsBody?.isDynamic = true
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
    
   
    

    override func willMove(from view: SKView) {
        super.willMove(from: view)
        removeAllChildren()
        removeAllActions()
    }

    
    override func didSimulatePhysics() {
        let v = donutNode.physicsBody!.velocity
        let speed = sqrt(pow(v.dx, 2) + pow(v.dy, 2))
        pastVelocities.append(speed)
        
        pastAccelerations.append(pastAccelerations.last!)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
    }
    
    
    
    
    
}
