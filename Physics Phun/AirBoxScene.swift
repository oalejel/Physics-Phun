//
//  ResistivityScene.swift
//  AppLab
//
//  Created by Omar Alejel on 5/20/16.
//  Copyright © 2016 omar alejel. All rights reserved.
//

import UIKit
import SceneKit

class Particle: SCNNode {
    var storedVelocity: SCNVector3 = SCNVector3Make(0,0,0)
    var motionPaused = false
    
    func pauseMotion() {
        //if physicsBody!.velocity.x + physicsBody!.velocity.y + physicsBody!.velocity.z != 0 {
            storedVelocity = physicsBody!.velocity
        //}
        physicsBody!.velocity = SCNVector3Make(0, 0, 0)
        motionPaused = true
    }
    
    func resumeMotion() {
        physicsBody?.velocity = storedVelocity
        motionPaused = false
    }
    

}

class AirBoxScene: SCNScene, SCNPhysicsContactDelegate {
    
    let sphereBitMask: Int = 0x000F
    let boxBitMask: Int = 0x00F0
    
    var spheres: [Particle] = []

    var boxNode: SCNNode!
    var faceNodes: [SCNNode] = []
//    var wireNode: SCNNode!
    
    var reflectionAllowed = true
    
    override init() {
        super.init()
        
//        let boxGeo = SCNBox(width: 10, height: 10, length: 10, chamferRadius: 0)
//        let boxNode = SCNNode(geometry: boxGeo)
//        boxNode.physicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.Kinematic, shape: SCNPhysicsShape(geometry: boxGeo, options: nil))
//        
//        
//        boxNode.opacity = 0.5
//        boxNode.position = SCNVector3Make(-5, 0, 0)
//        rootNode.addChildNode(boxNode)
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = SCNVector3Make(0, 0, 0)
        
        let edgeVector = SCNVector3Make(10, 0.5, 0.5)
        
        func edge(vector: SCNVector3) -> SCNNode {
            let edgeGeo = SCNBox(width: CGFloat(vector.x), height: CGFloat(vector.y), length: CGFloat(vector.z), chamferRadius: 0.2)
            edgeGeo.firstMaterial?.diffuse.contents = UIColor.blackColor()
            let edgeNode = SCNNode(geometry: edgeGeo)
            return edgeNode
        }
        
        func face(vector: SCNVector3) -> SCNNode {
            var lengthenedEdge = edgeVector
            lengthenedEdge.x += edgeVector.y
            let edge1 = edge(edgeVector)
            let edge2 = edge(edgeVector)
            let edge3 = edge(lengthenedEdge)
            let edge4 = edge(lengthenedEdge)
            
            //might want to shift z by half of the vector z... see later...
            edge1.position = SCNVector3Make(vector.x / -2, vector.x / -2, 0)
            edge2.position = SCNVector3Make(vector.x / -2, vector.x / 2, 0)
            
            edge3.rotation = SCNVector4Make(0, 0, 1, Float(M_PI / 2))
//            edge3.position = SCNVector3Make(0, 0, 0)
            
            edge4.rotation = SCNVector4Make(0, 0, 1, Float(M_PI / 2))
            edge4.position = SCNVector3Make((-vector.x), 0, 0)
            
            let sumNode = SCNNode()
            sumNode.addChildNode(edge1)
            sumNode.addChildNode(edge2)
            sumNode.addChildNode(edge3)
            sumNode.addChildNode(edge4)
            
            let plane2Geometry = SCNBox(width: CGFloat(vector.x), height: CGFloat(vector.x), length: 0.2, chamferRadius: 0)
            let plane2Node = SCNNode(geometry: plane2Geometry)
            plane2Node.opacity = 0.5
            plane2Node.physicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.Kinematic, shape: SCNPhysicsShape(geometry: plane2Geometry, options: nil))
            plane2Node.position = SCNVector3Make(vector.x / -2, 0, -0.1)
            
            plane2Node.physicsBody?.collisionBitMask = sphereBitMask
            plane2Node.physicsBody?.categoryBitMask = boxBitMask
            plane2Node.physicsBody?.contactTestBitMask = sphereBitMask
            plane2Node.physicsBody?.friction = 0
            plane2Node.physicsBody?.restitution =  1
            plane2Node.physicsBody?.damping = 0
            
            sumNode.addChildNode(plane2Node)
            
//            let planeGeometry = SCNBox(width: CGFloat(vector.x), height: CGFloat(vector.x), length: 0.2, chamferRadius: 0)
//            let planeNode = SCNNode(geometry: planeGeometry)
//            planeNode.opacity = 0.5
//            planeNode.physicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.Kinematic, shape: SCNPhysicsShape(geometry: planeGeometry, options: nil))
//            planeNode.position = SCNVector3Make(vector.x / -2, 0, 0)
//            
//            planeNode.physicsBody?.collisionBitMask = sphereBitMask
//            planeNode.physicsBody?.categoryBitMask = boxBitMask
//            planeNode.physicsBody?.contactTestBitMask = sphereBitMask
//            planeNode.physicsBody?.friction = 0
//            planeNode.physicsBody?.restitution =  1
//            planeNode.physicsBody?.damping = 0
//            
//            sumNode.addChildNode(planeNode)
            
            return sumNode
        }
        
        let face1Node = face(edgeVector)
        face1Node.position = SCNVector3Make(0, 0, edgeVector.x / -2)
        
        let face2Node = face(edgeVector)
        face2Node.position = SCNVector3Make(0, 0, edgeVector.x / 2)
        
        let face3Node = face(edgeVector)
        face3Node.rotation = SCNVector4Make(0, 1, 0, Float(M_PI / 2))
        face3Node.position = SCNVector3Make(0, 0, edgeVector.x / -2)
        
        let face4Node = face(edgeVector)
        face4Node.rotation = SCNVector4Make(0, 1, 0, Float(M_PI / 2))
        face4Node.position = SCNVector3Make(edgeVector.x / -1, 0, edgeVector.x / -2)
        
        let face5Node = face(edgeVector)
        face5Node.rotation = SCNVector4Make(1, 0, 0, Float(M_PI / 2))
        face5Node.position = SCNVector3Make(0, edgeVector.x / -2, 0)
        
        let face6Node = face(edgeVector)
        face6Node.rotation = SCNVector4Make(1, 0, 0, Float(M_PI / 2))
        face6Node.position = SCNVector3Make(0, edgeVector.x / 2, 0)
        
        //have a node that contains the box so that we scale it when needed
        boxNode = SCNNode()
       
        boxNode.addChildNode(face1Node)
        boxNode.addChildNode(face2Node)
        boxNode.addChildNode(face3Node)
        boxNode.addChildNode(face4Node)
        boxNode.addChildNode(face5Node)
        boxNode.addChildNode(face6Node)
        faceNodes.appendContentsOf([face1Node, face2Node, face3Node, face4Node, face5Node, face6Node])
        
        let inset = Float(edgeVector.x / -2)
        boxNode.pivot = SCNMatrix4MakeTranslation(inset, 0, inset)
        
        rootNode.addChildNode(boxNode)
        ///work on the camear when you want to perfect this....
//        let camera = SCNCamera()
//        camera.zNear = 12
//        rootNode.camera = camera
    }
    
    func generateParticles(count: Int) {
        for _ in 0..<count {
            let sphereGeo = SCNSphere(radius: 0.25)
            let sphereNode = Particle()
            sphereNode.geometry = sphereGeo
            sphereNode.position = SCNVector3Make(0, 0, 0)
            
            sphereNode.physicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.Dynamic, shape: SCNPhysicsShape(geometry: sphereGeo, options: nil))
            sphereNode.physicsBody?.collisionBitMask = boxBitMask
            sphereNode.physicsBody?.categoryBitMask = sphereBitMask
            sphereNode.physicsBody?.contactTestBitMask = boxBitMask
            sphereNode.physicsBody?.velocity = randomVector(20)
            
            //in case we are ....?
            if let random = spheres.last {
                if random.motionPaused {
                    sphereNode.pauseMotion()
                }
            }
            
            spheres.append(sphereNode)
            
            rootNode.addChildNode(sphereNode)
        }
    }
    
    func removeParticles(count: Int) {
        for _ in 0..<count {
            if let sphere = self.spheres.popLast() {
                sphere.removeAllActions()
                sphere.removeFromParentNode()
                print(self.spheres.count)
            } else {
                return
            }
        }
    }
    
    func physicsWorld(world: SCNPhysicsWorld, didBeginContact contact: SCNPhysicsContact) {
        guard reflectionAllowed else {return}
        let contactNodes = [contact.nodeA, contact.nodeB]
        for node in contactNodes {
            if node.physicsBody?.categoryBitMask == sphereBitMask {
                let sphere = node as! Particle
                let newVector = randomVector(20)
                
                if sphere.motionPaused {
                    sphere.storedVelocity = newVector
                } else {
                    sphere.physicsBody?.velocity = newVector
                }
            }
        }
        
//        if bodySet.contains(boxBitMask) && bodySet.contains(sphereBitMask) {
//            print("contact with wall")
//            var ball: SCNNode!
////            var face: SCNNode!
//            
//            if contactNodes.first?.physicsBody?.categoryBitMask == boxBitMask {
////                face = contactNodes.first!
//                ball = contactNodes[1]
//            } else {
//                ball = contactNodes.first!
////                fa//"ce = contactNodes[1]
//            }
////            let oldVelocity = ball.physicsBody!.velocity
//        }
    }
    
    func randomVector(magnitude: Float) -> SCNVector3 {
        var x = Float(arc4random() % UInt32(magnitude))
        let yzSquaredSums = pow(magnitude, 2) - pow(x, 2)
        var y = Float(arc4random() % UInt32(sqrt(yzSquaredSums)))
        var z = sqrt(yzSquaredSums - pow(y, 2))
        
        if arc4random() % 2 == 0 {x *= -1}
        if arc4random() % 2 == 0 {y *= -1}
        if arc4random() % 2 == 0 {z *= -1}
        
//        print("\(x, y, z)")
        
        return SCNVector3Make(x, y, z)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
}