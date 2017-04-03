//
//  DirectionControlView.swift
//  Physics Phun
//
//  Created by Omar Alejel on 7/21/16.
//  Copyright © 2016 omaralejel. All rights reserved.
//

import UIKit

protocol DirectionControlDelegate {
    func newPoint(_ p: CGPoint)
}

class DirectionControlView: UIView {
    var arrowHeadPoint: CGPoint?
    
    var directionDelegate: DirectionControlDelegate?

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let lineOffset: CGFloat = 20
        context!.setStrokeColor(UIColor.gray.cgColor)
        context!.setLineWidth(2)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: frame.size.width / 2, y: lineOffset))
        path.addLine(to: CGPoint(x: frame.size.width / 2, y: frame.size.height - lineOffset))
        path.stroke()
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: lineOffset, y: frame.size.height / 2))
        path2.addLine(to: CGPoint(x: frame.size.width - lineOffset, y: frame.size.height / 2))
        path2.stroke()
    
        if let arrowHeadPoint = arrowHeadPoint {
            context!.setStrokeColor(UIColor.green.cgColor)
            context!.setFillColor(UIColor.green.cgColor)
            context!.setLineWidth(10)
            
            let arrowPath = UIBezierPath()
            arrowPath.move(to: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2))
            arrowPath.addLine(to: arrowHeadPoint)
            arrowPath.stroke()
            
            
            
            
//            var slope = arrowHeadPoint.y / arrowHeadPoint.x
//            if slope > 0 && arrowHeadPoint.y < 0 && arrowHeadPoint.x < 0 {
//                slope *= -1
//            }
            
            let x = arrowHeadPoint.x - (frame.size.width / 2)
            let y = (frame.size.height / 2) - arrowHeadPoint.y
            
            var theta = atan(y / x)
            if y < 0 && x < 0 {
                theta = theta + CGFloat(Double.pi)
            } else if x < 0 && y > 0 {
                theta = theta + CGFloat(Double.pi)
            }
    
            
//            print(theta * (180 / CGFloat(Double.pi)))
            
            
            let triangleHeadPath = UIBezierPath()
            triangleHeadPath.move(to: CGPoint(x: lineOffset / 2, y: lineOffset))
            triangleHeadPath.addLine(to: CGPoint(x: lineOffset, y: 0))
            triangleHeadPath.addLine(to: CGPoint(x: 0, y: 0))
            triangleHeadPath.close()
            
            
            
            let box = triangleHeadPath.cgPath.boundingBox
            let center = CGPoint(x:box.midX, y:box.midY)
            
            let toOrigin = CGAffineTransform(translationX: -center.x, y: -center.y)
            triangleHeadPath.apply(toOrigin)
            
            let rotate = CGAffineTransform(rotationAngle: -theta - CGFloat(Double.pi / 2))
            triangleHeadPath.apply(rotate)
            
            let fromOrigin = CGAffineTransform(translationX: center.x, y: center.y)
            triangleHeadPath.apply(fromOrigin)
            
            let translate = CGAffineTransform(translationX: arrowHeadPoint.x - (lineOffset / 2), y: arrowHeadPoint.y - (lineOffset / 2))
            triangleHeadPath.apply(translate)

            triangleHeadPath.fill()

            
            context!.setStrokeColor(UIColor.blue.cgColor)
            context!.setFillColor(UIColor.blue.cgColor)
            
            let yArrowPath = UIBezierPath()
            yArrowPath.move(to: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2))
            yArrowPath.addLine(to: CGPoint(x: frame.size.width / 2, y: arrowHeadPoint.y))
            yArrowPath.stroke()
            
            
            ///
            let negativeY = (arrowHeadPoint.y < (frame.size.height / 2)) ? true : false
            
            let yTriangleHeadPath = UIBezierPath()
            yTriangleHeadPath.move(to: CGPoint(x: lineOffset / 2, y: lineOffset))
            yTriangleHeadPath.addLine(to: CGPoint(x: lineOffset, y: 0))
            yTriangleHeadPath.addLine(to: CGPoint(x: 0, y: 0))
            yTriangleHeadPath.close()
            
            
            //transformations for th X arrow like we did with the vector arrow
            let yBox = yTriangleHeadPath.cgPath.boundingBox
            let yCenter = CGPoint(x:yBox.midX, y:yBox.midY)
            
            let yToOrigin = CGAffineTransform(translationX: -yCenter.x, y: -yCenter.y)
            yTriangleHeadPath.apply(yToOrigin)
            
            let yRotate = CGAffineTransform(rotationAngle: negativeY ? CGFloat(Double.pi) : 0)
            yTriangleHeadPath.apply(yRotate)
            
            let yFromOrigin = CGAffineTransform(translationX: yCenter.x, y: yCenter.y)
            yTriangleHeadPath.apply(yFromOrigin)
            
            let xxShift = (frame.size.width / 2) - (lineOffset / 2)
            let xyShift = arrowHeadPoint.y + (-0.5 * lineOffset)
            let yTranslate = CGAffineTransform(translationX: xxShift, y: xyShift)
            yTriangleHeadPath.apply(yTranslate)
            
            yTriangleHeadPath.fill()
            
            
            context!.setStrokeColor(UIColor.red.cgColor)
            context!.setFillColor(UIColor.red.cgColor)
            
            let xArrowPath = UIBezierPath()
            xArrowPath.move(to: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2))
            xArrowPath.addLine(to: CGPoint(x: arrowHeadPoint.x, y: frame.size.height / 2))
            xArrowPath.stroke()
            
            let xTriangleHeadPath = UIBezierPath()
            xTriangleHeadPath.move(to: CGPoint(x: lineOffset / 2, y: lineOffset))
            xTriangleHeadPath.addLine(to: CGPoint(x: lineOffset, y: 0))
            xTriangleHeadPath.addLine(to: CGPoint(x: 0, y: 0))
            xTriangleHeadPath.close()
            
            let negativeX = (arrowHeadPoint.x < (frame.size.width / 2)) ? true : false
            
            //transformations for th X arrow like we did with the vector arrow
            let xBox = xTriangleHeadPath.cgPath.boundingBox
            let xCenter = CGPoint(x:xBox.midX, y:xBox.midY)
            
            let xToOrigin = CGAffineTransform(translationX: -xCenter.x, y: -xCenter.y)
            xTriangleHeadPath.apply(xToOrigin)
            
            let xRotate = CGAffineTransform(rotationAngle: negativeX ? CGFloat(Double.pi / 2) : CGFloat(Double.pi / -2))
            xTriangleHeadPath.apply(xRotate)
            
            let xFromOrigin = CGAffineTransform(translationX: xCenter.x, y: xCenter.y)
            xTriangleHeadPath.apply(xFromOrigin)
            
            let xShift = arrowHeadPoint.x + (-0.5 * lineOffset)
            let yShift = (frame.size.height / 2) - (lineOffset / 2)
            let xTranslate = CGAffineTransform(translationX: xShift, y: yShift)
            xTriangleHeadPath.apply(xTranslate)
            
            xTriangleHeadPath.fill()
        }
        
        
//         let path1 = UIBezierPath(roundedRect: <#T##CGRect#>, cornerRadius: <#T##CGFloat#>)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let t = touches.first
        let point = t?.location(in: self)
        arrowHeadPoint = point
        
        notifyDelegate()
        
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let t = touches.first
        let point = t?.location(in: self)
        arrowHeadPoint = point
        
        notifyDelegate()
        
        setNeedsDisplay()
    }
    
    func notifyDelegate() {
        if let donutController = directionDelegate {
            if let arrowHeadPoint = arrowHeadPoint {
                let x = arrowHeadPoint.x - (frame.size.width / 2)
                let y = (frame.size.height / 2) - arrowHeadPoint.y
                donutController.newPoint(CGPoint(x: x, y: y))
            }
        }
    }
}
