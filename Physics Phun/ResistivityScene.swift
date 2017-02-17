//
//  ResistivityScene.swift
//  AppLab
//
//  Created by Omar Alejel on 5/20/16.
//  Copyright © 2016 omar alejel. All rights reserved.
//

import UIKit
import SceneKit

class ResistivityScene: SCNScene {
    
    var areaTextNode: SCNNode!
    var lengthTextNode: SCNNode!
    var rohTextNode: SCNNode!
    var rTextNode: SCNNode!
    
    var wireNode: SCNNode!
    
    override init() {
        super.init()
        
        let tubeHeight: Float = 40
        let tubeGeo = SCNTube(innerRadius: 0, outerRadius: 5, height: CGFloat(tubeHeight))
        tubeGeo.firstMaterial!.diffuse.contents = UIColor.orangeColor()
        tubeGeo.firstMaterial!.specular.contents = UIColor.blackColor()
        
    
        wireNode = SCNNode(geometry: tubeGeo)
//            tube.position = 
        wireNode.rotation = SCNVector4Make(0.5, 0, 1, Float(M_PI * 0.5))
        wireNode.position = SCNVector3Make(0, -15, 0)
        wireNode.opacity = 1/3
        rootNode.addChildNode(wireNode)
        
        let rGeometry = SCNText(string: "R", extrusionDepth: 5)
        rGeometry.firstMaterial?.diffuse.contents = UIColor.redColor()
        rTextNode = SCNNode(geometry: rGeometry)
        rTextNode.position = SCNVector3Make(-15, 6, 0)
        var rVMin = SCNVector3Zero
        var rVMax = SCNVector3Zero
        rTextNode.getBoundingBoxMin(&rVMin, max: &rVMax)
        rTextNode.pivot = SCNMatrix4MakeTranslation(rVMax.x / 2, rVMax.y / 2, rVMax.z / 2)
        rootNode.addChildNode(rTextNode)
        
        let equalsGeometry = SCNText(string: "=", extrusionDepth: 5)
        equalsGeometry.firstMaterial?.diffuse.contents = UIColor.blackColor()
        let equalsTextNode = SCNNode(geometry: equalsGeometry)
        equalsTextNode.position = SCNVector3Make(-5, 0, 0)
        rootNode.addChildNode(equalsTextNode)
        
        let separatorGeometry = SCNBox(width: 20, height: 1, length: 5, chamferRadius: 0)
        separatorGeometry.firstMaterial?.diffuse.contents = UIColor.blackColor()
        let separatorNode = SCNNode(geometry: separatorGeometry)
        separatorNode.position = SCNVector3Make(20, 6, 0)
        rootNode.addChildNode(separatorNode)
        
        let rohGeometry = SCNText(string: "ρ", extrusionDepth: 5)
        rohGeometry.firstMaterial?.diffuse.contents = UIColor.blueColor()
        rohTextNode = SCNNode(geometry: rohGeometry)
        rohTextNode.position = SCNVector3Make(14, 13, 0)
        var rohVMin = SCNVector3Zero
        var rohVMax = SCNVector3Zero
        rohTextNode.getBoundingBoxMin(&rohVMin, max: &rohVMax)
        rohTextNode.pivot = SCNMatrix4MakeTranslation(rohVMax.x / 2, rVMax.y / 2, rohVMax.z / 2)
        rootNode.addChildNode(rohTextNode)
        
        let lengthGeometry = SCNText(string: "L", extrusionDepth: 5)
        lengthGeometry.firstMaterial?.diffuse.contents = UIColor.blueColor()
        lengthTextNode = SCNNode(geometry: lengthGeometry)
        lengthTextNode.position = SCNVector3Make(24, 11, 0)
        var lVMin = SCNVector3Zero
        var lVMax = SCNVector3Zero
        lengthTextNode.getBoundingBoxMin(&lVMin, max: &lVMax)
        lengthTextNode.pivot = SCNMatrix4MakeTranslation(lVMax.x / 2, lVMax.y / 2, lVMax.z / 2)
        rootNode.addChildNode(lengthTextNode)
        
        let areaGeometry = SCNText(string: "A", extrusionDepth: 5)
        areaGeometry.firstMaterial?.diffuse.contents = UIColor.blueColor()
        areaTextNode = SCNNode(geometry: areaGeometry)
        areaTextNode.position = SCNVector3Make(19, -4, 0)
        var aVMin = SCNVector3Zero
        var aVMax = SCNVector3Zero
        areaTextNode.getBoundingBoxMin(&aVMin, max: &aVMax)
        areaTextNode.pivot = SCNMatrix4MakeTranslation(aVMax.x / 2, aVMax.y / 2, aVMax.z / 2)
        rootNode.addChildNode(areaTextNode)
        
//        addTube(SCNVector3Make(Float(tubeHeight / 4), 0, Float(2 * tubeHeight / 4.0)))

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
