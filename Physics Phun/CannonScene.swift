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
    
    var launchDate: NSDate? = nil
    
    var launchAngle: Float = 0.0
    var launchSpeed: Float = 0.0
    
    let degreesToRadians = Float(M_PI / 180)
    
    var timeLabel: SKLabelNode?
    var heightLabel: SKLabelNode?
    var distanceLabel: SKLabelNode?
    
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
                
        backgroundColor = UIColor(red: 1, green: 230/255, blue: 179/255, alpha: 1)
        
        let cannonPlatform = SKSpriteNode(color: SKColor.grayColor(), size: CGSizeMake(50, size.height / 2))
        cannonPlatform.anchorPoint = CGPointMake(0, 0)
        cannonPlatform.position = CGPointMake(0, 0)
        addChild(cannonPlatform)
        
        cannon = SKSpriteNode(imageNamed: "cannon")
        cannon.setScale(30 / cannon.size.width)
        cannon.anchorPoint = CGPointMake(0.3, 0.5)
        cannon.position = CGPointMake(cannonPlatform.frame.size.width / 2, cannonPlatform.frame.size.height + 18)
        cannon.runAction(SKAction.rotateToAngle(CGFloat(M_PI / 4), duration: 0))
        addChild(cannon)
        
        cannonBase = SKSpriteNode(imageNamed: "cannon_base")
        cannonBase.setScale(30 / cannonBase.size.width)
        cannonBase.anchorPoint = CGPointMake(0.5, 0.5)
        cannonBase.position = CGPointMake(cannonPlatform.frame.size.width / 2, cannonPlatform.frame.size.height + 10)
        addChild(cannonBase)
        
        physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        physicsBody?.restitution = 0
        physicsBody?.contactTestBitMask = 0x00F0
        
        physicsWorld.contactDelegate = self
    }
    
    func updateCannonAngle(a: Float) {
        let rotate = SKAction.rotateToAngle(CGFloat(M_PI) * CGFloat(a) / 180, duration: 0.1)
        cannon.runAction(rotate)
    }
    
    func launch(angle: Float, speed: Float, fieldStrength: Float) {
        launchAngle = angle
        launchSpeed = speed
        
        physicsWorld.gravity = CGVectorMake(0, CGFloat(-fieldStrength))
        
        if let ball = ball {
            ball.removeFromParent()
            self.ball = nil
        }
        
        ball = SKShapeNode(circleOfRadius: 4)
        ball.fillColor = SKColor.blackColor()
        ball.strokeColor = SKColor.blackColor()
        ball.position = cannon.position
        ball.physicsBody?.contactTestBitMask = 0x000F
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        ball.physicsBody?.restitution = 0
        addChild(ball)
        ball.zPosition = -1
    
        
        let vector = CGVector(dx: CGFloat(speed) * CGFloat(cos(CGFloat(M_PI) * CGFloat(angle) / 180)), dy: CGFloat(speed) * CGFloat(sin(degreesToRadians * angle)))
           ball.physicsBody?.velocity = vector
            // Fallback on earlier versions
        
        launched = true
        landed = false
        
        launchDate = NSDate()
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
                pointNode.fillColor = SKColor.redColor()
                pointNode.strokeColor = UIColor.redColor()
                pointNode.position = ball.position
                addChild(pointNode)
                pathPointNodes[currentBallIndex].append(pointNode)
            }
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        landed = true
        ball.physicsBody?.velocity = CGVectorMake(0, 0)
        ball.physicsBody?.affectedByGravity = false
        //increment to next ball. need to add a new blank array for the next set of points!
        currentBallIndex += 1
        pathPointNodes.append([])
        
        //show results: time elapsed, distance travelled, max height
        if let launchDate = launchDate {
            let curdate = NSDate()
            let seconds = curdate.timeIntervalSinceDate(launchDate)
            print("took \(round(seconds * 100) / 100) seconds to land")
            
            
            //-b/2a is the  vertical velocity divided by the field strength!!!
            let maxHeight = cannon.position.y + (CGFloat(sin(degreesToRadians * launchAngle) * launchSpeed) / CGFloat(-physicsWorld.gravity.dy))
            print("maxheight was: \(round(maxHeight * 100) / 100)")
            
            let distance = CGFloat(cos(degreesToRadians * launchAngle) * launchSpeed) * CGFloat(seconds)
            
            timeLabel?.removeFromParent()
            heightLabel?.removeFromParent()
            distanceLabel?.removeFromParent()
            
            timeLabel = SKLabelNode(text: "∆t: \(round(seconds * 100) / 100) seconds")
            timeLabel?.fontColor = SKColor.blackColor()
            timeLabel?.fontName = "Helvetica"
            timeLabel?.fontSize = 10
            timeLabel?.horizontalAlignmentMode = .Right
            
            heightLabel = SKLabelNode(text: "Max Height: \(round(maxHeight * 100) / 100) pixels")
            heightLabel?.fontColor = SKColor.blackColor()
            heightLabel?.fontName = "Helvetica"
            heightLabel?.fontSize = 10
            heightLabel?.horizontalAlignmentMode = .Right
            
            distanceLabel = SKLabelNode(text: "Distance: \(round(distance * 100) / 100) pixels")
            distanceLabel?.fontColor = SKColor.blackColor()
            distanceLabel?.fontName = "Helvetica"
            distanceLabel?.fontSize = 10
            distanceLabel?.horizontalAlignmentMode = .Right
            
            timeLabel?.position = CGPointMake(frame.size.width, frame.size.height - 20)
            addChild(timeLabel!)
            
            heightLabel?.position = CGPointMake(frame.size.width, frame.size.height - 40)
            addChild(heightLabel!)
            
            distanceLabel?.position = CGPointMake(frame.size.width, frame.size.height - 60)
            addChild(distanceLabel!)
            
//            heightLabel?.position = CGPointMake(frame.size.width, frame.size.height - timelabel.frame.size.height)
        }
    }
    
    
}
