//
//  VIRPScene.swift
//  AppLab
//
//  Created by Omar Alejel on 5/20/16.
//  Copyright © 2016 omar alejel. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class VIRPScene: SKScene {
    var resistanceLabel: SKLabelNode!
    var resistorNode: SKShapeNode!
    var circuitBorderNode: SKShapeNode!
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        backgroundColor = UIColor(red: 1, green: 230/255, blue: 179/255, alpha: 1)

        let strokeWidth: CGFloat = 7
        let circuitSize = CGSizeMake(size.width / 1.3, size.height / 1.5)
        circuitBorderNode = borderBoxNode(circuitSize, strokeWidth: strokeWidth, fillColor: SKColor.clearColor())
        circuitBorderNode.position = CGPointMake(size.width / 2, size.height / 2)
        addChild(circuitBorderNode)
        
        let resistorSize = CGSizeMake(circuitSize.width / 2.5, circuitSize.width / 6)
        resistorNode =  borderBoxNode(resistorSize, strokeWidth: 4, fillColor: backgroundColor)
        resistorNode.position = CGPointMake(size.width / 2, circuitBorderNode.position.y - (circuitSize.height / 2))
        self.resistorNode.zPosition = 10
        addChild(resistorNode)
        
        resistanceLabel = SKLabelNode(text: "Ω")
        resistanceLabel.fontColor = SKColor.blackColor()
        resistanceLabel.fontName = "Helvetica-Bold"
        resistanceLabel.fontSize = 15
        resistanceLabel.position = CGPointMake(size.width / 2, resistorNode.position.y - (resistanceLabel.frame.size.height / 2))
        self.resistanceLabel.zPosition = 10
        addChild(resistanceLabel)
        
        
        
        let addElectron = SKAction.runBlock { 
            let electron = SKShapeNode(circleOfRadius: 2)
            electron.fillColor = SKColor.yellowColor()
            electron.zPosition = self.circuitBorderNode.zPosition + 1
            
            //        electron.anchorPoint = CGPointMake(0.5, 0.5)
            electron.position = CGPointMake((strokeWidth / 2) + (self.size.width / 2) - (self.circuitBorderNode.frame.size.width / 2), (strokeWidth / 2) + (self.size.height / 2) - (self.circuitBorderNode.frame.size.height / 2))
            self.addChild(electron)
            var innerFrame = CGRectInset(self.circuitBorderNode.frame, strokeWidth / 2, strokeWidth / 2)
            innerFrame.origin.x = 0
            innerFrame.origin.y = 0
            let path = UIBezierPath(rect: innerFrame)
            electron.runAction(SKAction.repeatActionForever(SKAction.followPath(path.CGPath, speed: 200)))
        }
        let wait = SKAction.waitForDuration(0.1)
        let addAndAndWait = SKAction.sequence([addElectron, wait])
        
//        let speedUp = SKAction.runBlock {
//            self.speed = 4
//        }
        let slowDown = SKAction.runBlock({ 
            self.speed = 1
            }, queue: dispatch_get_main_queue())
        speed = 3
        let repeatAddElectron = SKAction.repeatAction(addAndAndWait, count: 45)
        let sequence = SKAction.sequence([repeatAddElectron, slowDown])
//        let fullSequence = SKAction.sequence([speedUp, repeatAddElectron, slowDown])
        runAction(sequence)
        
        let cellNode = SKSpriteNode(color: backgroundColor, size: CGSizeMake(circuitSize.width / 14, circuitSize.width / 5.5))
        cellNode.anchorPoint = CGPointMake(0.5, 0.5)
        cellNode.position = CGPointMake(size.width  / 2, circuitBorderNode.position.y + (circuitBorderNode.frame.size.height / 2) - (strokeWidth / 2))
        cellNode.zPosition = 10
        addChild(cellNode)
        
        let anode = SKShapeNode(rectOfSize: CGSizeMake(cellNode.size.width / 3, cellNode.size.height / 2))
        anode.fillColor = SKColor.blackColor()
        anode.strokeColor = SKColor.clearColor()
        anode.position = CGPointMake((cellNode.size.width / -2) + (anode.frame.size.width / 2), 0)
        cellNode.addChild(anode)
        
        let cathode = SKShapeNode(rectOfSize: CGSizeMake(cellNode.size.width / 3, cellNode.size.height))
        cathode.fillColor = SKColor.blackColor()
        cathode.strokeColor = SKColor.clearColor()
        cathode.position = CGPointMake((cellNode.size.width / 2) - (cathode.frame.size.width / 2), 0)
        cellNode.addChild(cathode)
        
        let anodeLabel = SKLabelNode(text: "–")
        anodeLabel.fontSize = 15
        anodeLabel.fontColor = SKColor.blackColor()
        anodeLabel.fontName = "Helvetica-Bold"
        anodeLabel.position = CGPointMake(cellNode.position.x - (cellNode.size.width + 4), cellNode.position.y + (cellNode.size.height / 4))
        addChild(anodeLabel)
        
        
        let cathodeLabel = SKLabelNode(text: "+")
        cathodeLabel.fontSize = 15
       cathodeLabel.fontColor = SKColor.blackColor()
        cathodeLabel.fontName = "Helvetica-Bold"
        cathodeLabel.position = CGPointMake(cellNode.position.x + (cellNode.size.width + 4), cellNode.position.y + (cellNode.size.height / 4))
        addChild(cathodeLabel)
        
        
//        VIRPBase = SKSpriteNode(imageNamed: "VIRP_base")
//        VIRPBase.setScale(30 / VIRPBase.size.width)
//        VIRPBase.anchorPoint = CGPointMake(0.5, 0.5)
//        VIRPBase.position = CGPointMake(VIRPPlatform.frame.size.width / 2, VIRPPlatform.frame.size.height + 10)
//        addChild(VIRPBase)

    }
    

    
    func borderBoxNode(boxSize: CGSize, strokeWidth: CGFloat, fillColor: SKColor) -> SKShapeNode {
        let boxNode = SKShapeNode(rectOfSize: boxSize)
        boxNode.lineWidth = strokeWidth
        boxNode.strokeColor = UIColor.blackColor()
        boxNode.fillColor = fillColor
        return boxNode
    }

    override func willMoveFromView(view: SKView) {
        super.willMoveFromView(view)
        removeAllChildren()
        removeAllActions()
    }
    
    func updateResistorNode(xScaleFactor: CGFloat) {
//        let scale = SKAction.scaleXTo(xScaleFactor, duration: 0.5)
//        resistorNode.runAction(scale)
        resistorNode.xScale = xScaleFactor
    }
    
    func updateCurrent(ratio: CGFloat) {
        speed = ratio
    }
    
    
}
