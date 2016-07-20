//
//  CannonScene.swift
//  AppLab
//
//  Created by Omar Alejel on 5/20/16.
//  Copyright © 2016 omar alejel. All rights reserved.
//

import UIKit
import SpriteKit

class CannonScene: SKScene {
    var cannon: SKSpriteNode!
    
    
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
//        print(physicsWorld)
        
        let cannonBaseNode = SKSpriteNode(color: SKColor.grayColor(), size: CGSizeMake(50, size.height / 2))
        cannonBaseNode.anchorPoint = CGPointMake(0, 0)
        cannonBaseNode.position = CGPointMake(0, 0)
        addChild(cannonBaseNode)
        
        cannon = SKSpriteNode(imageNamed: "cannon")
        cannon.setScale(30 / cannon.size.width)
        cannon.anchorPoint = CGPointMake(0.2, 0.5)
        cannon.position = CGPointMake(cannonBaseNode.frame.size.width / 2, cannonBaseNode.frame.size.height + 10)
        cannon.runAction(SKAction.rotateToAngle(CGFloat(M_PI / 4), duration: 0))
        addChild(cannon)
        
        physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    }
    
    func setCannonAngle(a: Float) {
        let rotate = SKAction.rotateToAngle(CGFloat(M_PI) * CGFloat(a) / 180, duration: 0.1)
        cannon.runAction(rotate)
    }
    
    func launch(angle: Float, speed: Float) {
        let ball = SKShapeNode(circleOfRadius: 2)
        ball.fillColor = SKColor.blackColor()
        ball.strokeColor = SKColor.blackColor()
        ball.position = cannon.position
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        addChild(ball)
        ball.zPosition = -1
        
        
        
        let vector = CGVector(dx: CGFloat(speed) * CGFloat(cos(CGFloat(M_PI) * CGFloat(angle) / 180)), dy: CGFloat(speed) * CGFloat(sin(CGFloat(M_PI) * CGFloat(angle) / 180)))
           ball.physicsBody?.velocity = vector
            // Fallback on earlier versions
        
    }
    
}
