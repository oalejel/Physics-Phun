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

class VIRPScene: ExperimentScene {
    var resistanceLabel: SKLabelNode!
    var resistorNode: SKSpriteNode!
    var circuitBorderNode: SKShapeNode!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        backgroundColor = UIColor(red: 1, green: 230/255, blue: 179/255, alpha: 1)

        let strokeWidth: CGFloat = 7
        let circuitSize = CGSize(width: size.width / 1.3, height: size.height / 1.5)
        let cellWidth = circuitSize.width / 14
        
        circuitBorderNode = borderBoxNode(circuitSize, strokeWidth: strokeWidth, fillColor: SKColor.clear, gapWidth: cellWidth / 3)
        circuitBorderNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        circuitBorderNode.lineJoin = .round
        addChild(circuitBorderNode)
        
        let resistorSize = CGSize(width: circuitSize.width / 2.5, height: circuitSize.width / 6)
        resistorNode =  SKSpriteNode(color: .black, size: resistorSize)
        resistorNode.position = CGPoint(x: size.width / 2, y: circuitBorderNode.position.y - (circuitSize.height / 2))
        self.resistorNode.zPosition = 10
        addChild(resistorNode)
        
        resistanceLabel = SKLabelNode(text: "Ω")
        resistanceLabel.fontColor = SKColor.white
        resistanceLabel.fontName = "Helvetica-Bold"
        resistanceLabel.fontSize = 15
        resistanceLabel.position = CGPoint(x: size.width / 2, y: resistorNode.position.y - (resistanceLabel.frame.size.height / 2))
        self.resistanceLabel.zPosition = 10
        addChild(resistanceLabel)
        
        
        
        let addElectron = SKAction.run { 
            let electron = SKShapeNode(circleOfRadius: 2)
            electron.fillColor = SKColor.yellow
            electron.zPosition = self.circuitBorderNode.zPosition + 1
            
            //        electron.anchorPoint = CGPointMake(0.5, 0.5)
            electron.position = CGPoint(x: (strokeWidth / 2) + (self.size.width / 2) - (self.circuitBorderNode.frame.size.width / 2), y: (strokeWidth / 2) + (self.size.height / 2) - (self.circuitBorderNode.frame.size.height / 2))
            self.addChild(electron)
            var innerFrame = self.circuitBorderNode.frame.insetBy(dx: strokeWidth / 2, dy: strokeWidth / 2)
            innerFrame.origin.x = 0
            innerFrame.origin.y = 0
            let path = UIBezierPath(rect: innerFrame)
            electron.run(SKAction.sequence([SKAction.follow(path.cgPath, speed: 200), SKAction.run({ 
                electron.removeAllActions()
                electron.removeFromParent()
            })]))
        }
        let wait = SKAction.wait(forDuration: 0.1)
        let addAndWait = SKAction.sequence([addElectron, wait])
        
//        let speedUp = SKAction.runBlock {
//            self.speed = 4
//        }
        let slowDown = SKAction.run({ 
            self.speed = 1
            }, queue: DispatchQueue.main)
        speed = 3
        let repeatAddElectron45 = SKAction.repeat(addAndWait, count: 45)
        let repeatForeverAddElectron = SKAction.repeatForever(addAndWait)
        let sequence = SKAction.sequence([repeatAddElectron45, slowDown, repeatForeverAddElectron])
//        let fullSequence = SKAction.sequence([speedUp, repeatAddElectron, slowDown])
        run(sequence)
        
        let cellNode = SKSpriteNode(color: .clear, size: CGSize(width: cellWidth, height: circuitSize.width / 5.5))
        cellNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        cellNode.position = CGPoint(x: size.width  / 2, y: circuitBorderNode.position.y + (circuitBorderNode.frame.size.height / 2) - (strokeWidth / 2))
        cellNode.zPosition = 10
        addChild(cellNode)
        
        let anode = SKShapeNode(rectOf: CGSize(width: cellNode.size.width / 3, height: cellNode.size.height / 2))
        anode.fillColor = SKColor.black
        anode.strokeColor = SKColor.clear
        anode.position = CGPoint(x: (cellNode.size.width / -2) + (anode.frame.size.width / 2), y: 0)
        cellNode.addChild(anode)
        
        let cathode = SKShapeNode(rectOf: CGSize(width: cellNode.size.width / 3, height: cellNode.size.height))
        cathode.fillColor = SKColor.black
        cathode.strokeColor = SKColor.clear
        cathode.position = CGPoint(x: (cellNode.size.width / 2) - (cathode.frame.size.width / 2), y: 0)
        cellNode.addChild(cathode)
        
        let anodeLabel = SKLabelNode(text: "–")
        anodeLabel.fontSize = 15
        anodeLabel.fontColor = SKColor.black
        anodeLabel.fontName = "Helvetica-Bold"
        anodeLabel.position = CGPoint(x: cellNode.position.x - (cellNode.size.width + 4), y: cellNode.position.y + (cellNode.size.height / 4))
        addChild(anodeLabel)
        
        let cathodeLabel = SKLabelNode(text: "+")
        cathodeLabel.fontSize = 15
       cathodeLabel.fontColor = SKColor.black
        cathodeLabel.fontName = "Helvetica-Bold"
        cathodeLabel.position = CGPoint(x: cellNode.position.x + (cellNode.size.width + 4), y: cellNode.position.y + (cellNode.size.height / 4))
        addChild(cathodeLabel)
        
        
//        VIRPBase = SKSpriteNode(imageNamed: "VIRP_base")
//        VIRPBase.setScale(30 / VIRPBase.size.width)
//        VIRPBase.anchorPoint = CGPointMake(0.5, 0.5)
//        VIRPBase.position = CGPointMake(VIRPPlatform.frame.size.width / 2, VIRPPlatform.frame.size.height + 10)
//        addChild(VIRPBase)

    }
    
    func borderBoxNode(_ boxSize: CGSize, strokeWidth: CGFloat, fillColor: SKColor, gapWidth: CGFloat) -> SKShapeNode {
        
        let boxNode = SKShapeNode(rectOf: boxSize)

        let boxPath = UIBezierPath()
        boxPath.move(to: CGPoint(x: (boxSize.width + gapWidth) * 0.5 - (boxSize.width / 2), y: boxSize.height - (boxSize.height / 2)))
        boxPath.addLine(to: CGPoint(x: boxSize.width - (boxSize.width / 2), y: boxSize.height - (boxSize.height / 2)))
        boxPath.addLine(to: CGPoint(x: boxSize.width - (boxSize.width / 2), y: 0 - (boxSize.height / 2)))
        boxPath.addLine(to: CGPoint(x: 0 - (boxSize.width / 2), y: 0 - (boxSize.height / 2)))
        boxPath.addLine(to: CGPoint(x: 0 - (boxSize.width / 2), y: boxSize.height - (boxSize.height / 2)))
        boxPath.addLine(to: CGPoint(x: (boxSize.width * 0.5) - (gapWidth * 0.5) - (boxSize.width / 2), y: boxSize.height - (boxSize.height / 2)))
        boxNode.path = boxPath.cgPath

        boxNode.lineWidth = strokeWidth
        boxNode.strokeColor = UIColor.black
        boxNode.fillColor = fillColor

        return boxNode
    }

    override func willMove(from view: SKView) {
        super.willMove(from: view)
        removeAllChildren()
        removeAllActions()
    }
    
    func updateResistorNode(_ xScaleFactor: CGFloat) {
        resistorNode.xScale = xScaleFactor
    }
    
    func updateCurrent(_ ratio: CGFloat) {
        speed = ratio
    }
    
    
}
