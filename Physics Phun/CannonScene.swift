//
//  CannonScene.swift
//  AppLab
//
//  Created by Omar Alejel on 5/20/16.
//  Copyright © 2016 omar alejel. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class CannonScene: SKScene, SKPhysicsContactDelegate {
    var cannon: SKSpriteNode!
    var cannonBase: SKSpriteNode!
    var ball: SKShapeNode!
    
    var launched = false
    var landed = false
    
    var framesAfterLaunch = 0
    
    var pathPointNodes: [[SKShapeNode]] = [[]]
    var currentBallIndex = 0
    
    var launchDate: Date? = nil
    
    var launchAngle: Float = 0.0
    var launchSpeed: Float = 0.0
    
    let degreesToRadians = Float(Double.pi / 180)
    
    var timeLabel: SKLabelNode?
    var heightLabel: SKLabelNode?
    var distanceLabel: SKLabelNode?
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
                
        backgroundColor = UIColor(red: 1, green: 230/255, blue: 179/255, alpha: 1)
        
        let cannonPlatform = SKSpriteNode(color: SKColor.gray, size: CGSize(width: 50, height: size.height / 2))
        cannonPlatform.anchorPoint = CGPoint(x: 0, y: 0)
        cannonPlatform.position = CGPoint(x: 0, y: 0)
        addChild(cannonPlatform)
        
        cannon = SKSpriteNode(imageNamed: "cannon")
        cannon.setScale(30 / cannon.size.width)
        cannon.anchorPoint = CGPoint(x: 0.3, y: 0.5)
        cannon.position = CGPoint(x: cannonPlatform.frame.size.width / 2, y: cannonPlatform.frame.size.height + 18)
        cannon.run(SKAction.rotate(toAngle: CGFloat(Double.pi / 4), duration: 0))
        addChild(cannon)
        
        cannonBase = SKSpriteNode(imageNamed: "cannon_base")
        cannonBase.setScale(30 / cannonBase.size.width)
        cannonBase.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        cannonBase.position = CGPoint(x: cannonPlatform.frame.size.width / 2, y: cannonPlatform.frame.size.height + 10)
        addChild(cannonBase)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        physicsBody?.restitution = 0
        physicsBody?.contactTestBitMask = 0x00F0
        
        physicsWorld.contactDelegate = self
    }
    
    func updateCannonAngle(_ a: Float) {
        let rotate = SKAction.rotate(toAngle: CGFloat(Double.pi) * CGFloat(a) / 180, duration: 0.1)
        cannon.run(rotate)
    }
    
    func launch(_ angle: Float, speed: Float, fieldStrength: Float) {
        launchAngle = angle
        launchSpeed = speed
        
        physicsWorld.gravity = CGVector(dx: 0, dy: CGFloat(-fieldStrength))
        
        if let ball = ball {
            ball.removeFromParent()
            self.ball = nil
        }
        
        ball = SKShapeNode(circleOfRadius: 4)
        ball.fillColor = SKColor.black
        ball.strokeColor = SKColor.black
        ball.position = cannon.position
        ball.physicsBody?.contactTestBitMask = 0x000F
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        ball.physicsBody?.restitution = 0
        addChild(ball)
        ball.zPosition = -1
    
        
        let vector = CGVector(dx: CGFloat(speed) * CGFloat(cos(CGFloat(Double.pi) * CGFloat(angle) / 180)), dy: CGFloat(speed) * CGFloat(sin(degreesToRadians * angle)))
           ball.physicsBody?.velocity = vector
            // Fallback on earlier versions
        
        launched = true
        landed = false
        
        launchDate = Date()
    }
    
    func clear() {
        currentBallIndex = 0
        for pointArray in pathPointNodes {
            for point in pointArray {
                point.removeFromParent()
            }
        }
        //clear that bastard!
        pathPointNodes = [[]]
        launched = false
    }
    
    override func didSimulatePhysics() {
        //WATCH OUT-->>
//        print("did simulate physics – check again for high CPU usage...")
        if !landed && launched {
            framesAfterLaunch += 1
            if framesAfterLaunch % 5 == 0 {
                let pointNode = SKShapeNode(circleOfRadius: 1)
                pointNode.fillColor = SKColor.red
                pointNode.strokeColor = UIColor.red
                pointNode.position = ball.position
                addChild(pointNode)
                pathPointNodes[currentBallIndex].append(pointNode)
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        landed = true
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        ball.physicsBody?.affectedByGravity = false
        //increment to next ball. need to add a new blank array for the next set of points!
        currentBallIndex += 1
        pathPointNodes.append([])
        
        //show results: time elapsed, distance travelled, max height
        if let launchDate = launchDate {
            let curdate = Date()
            let seconds = curdate.timeIntervalSince(launchDate)
            print("took \(round(seconds * 100) / 100) seconds to land")
            
            
            //-b/2a is the  vertical velocity divided by the field strength!!!
            let maxHeight = cannon.position.y + (CGFloat(sin(degreesToRadians * launchAngle) * launchSpeed) / CGFloat(-physicsWorld.gravity.dy))
            print("maxheight was: \(round(maxHeight * 100) / 100)")
            
            let distance = CGFloat(cos(degreesToRadians * launchAngle) * launchSpeed) * CGFloat(seconds)
            
            timeLabel?.removeFromParent()
            heightLabel?.removeFromParent()
            distanceLabel?.removeFromParent()
            
            timeLabel = SKLabelNode(text: "∆t: \(round(seconds * 100) / 100) seconds")
            timeLabel?.fontColor = SKColor.black
            timeLabel?.fontName = "Helvetica"
            timeLabel?.fontSize = 10
            timeLabel?.horizontalAlignmentMode = .right
            
            heightLabel = SKLabelNode(text: "Max Height: \(round(maxHeight * 100) / 100) pixels")
            heightLabel?.fontColor = SKColor.black
            heightLabel?.fontName = "Helvetica"
            heightLabel?.fontSize = 10
            heightLabel?.horizontalAlignmentMode = .right
            
            distanceLabel = SKLabelNode(text: "Distance: \(round(distance * 100) / 100) pixels")
            distanceLabel?.fontColor = SKColor.black
            distanceLabel?.fontName = "Helvetica"
            distanceLabel?.fontSize = 10
            distanceLabel?.horizontalAlignmentMode = .right
            
            timeLabel?.position = CGPoint(x: frame.size.width, y: frame.size.height - 20)
            addChild(timeLabel!)
            
            heightLabel?.position = CGPoint(x: frame.size.width, y: frame.size.height - 40)
            addChild(heightLabel!)
            
            distanceLabel?.position = CGPoint(x: frame.size.width, y: frame.size.height - 60)
            addChild(distanceLabel!)
            
//            heightLabel?.position = CGPointMake(frame.size.width, frame.size.height - timelabel.frame.size.height)
        }
    }
    
    override func willMove(from view: SKView) {
        super.willMove(from: view)
        removeAllChildren()
        removeAllActions()
    }
    
    
}
