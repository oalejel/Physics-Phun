//
//  DirectionControlView.swift
//  Physics Phun
//
//  Created by Omar Alejel on 7/21/16.
//  Copyright © 2016 omaralejel. All rights reserved.
//

import UIKit

protocol DirectionControlDelegate {
    func newPoint(p: CGPoint)
}

class DirectionControlView: UIView {
    var arrowHeadPoint: CGPoint?
    
    var directionDelegate: DirectionControlDelegate?

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let lineOffset: CGFloat = 20
        CGContextSetStrokeColorWithColor(context!, UIColor.grayColor().CGColor)
        CGContextSetLineWidth(context!, 2)
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(frame.size.width / 2, lineOffset))
        path.addLineToPoint(CGPointMake(frame.size.width / 2, frame.size.height - lineOffset))
        path.stroke()
        
        let path2 = UIBezierPath()
        path2.moveToPoint(CGPointMake(lineOffset, frame.size.height / 2))
        path2.addLineToPoint(CGPointMake(frame.size.width - lineOffset, frame.size.height / 2))
        path2.stroke()
    
        if let arrowHeadPoint = arrowHeadPoint {
            CGContextSetStrokeColorWithColor(context!, UIColor.greenColor().CGColor)
            CGContextSetFillColorWithColor(context!, UIColor.greenColor().CGColor)
            CGContextSetLineWidth(context!, 10)
            
            let arrowPath = UIBezierPath()
            arrowPath.moveToPoint(CGPointMake(frame.size.width / 2, frame.size.height / 2))
            arrowPath.addLineToPoint(arrowHeadPoint)
            arrowPath.stroke()
            
            
            
            
//            var slope = arrowHeadPoint.y / arrowHeadPoint.x
//            if slope > 0 && arrowHeadPoint.y < 0 && arrowHeadPoint.x < 0 {
//                slope *= -1
//            }
            
            let x = arrowHeadPoint.x - (frame.size.width / 2)
            let y = (frame.size.height / 2) - arrowHeadPoint.y
            
            var theta = atan(y / x)
            if y < 0 && x < 0 {
                theta = theta + CGFloat(M_PI)
            } else if x < 0 && y > 0 {
                theta = theta + CGFloat(M_PI)
            }
    
            
//            print(theta * (180 / CGFloat(M_PI)))
            
            
            let triangleHeadPath = UIBezierPath()
            triangleHeadPath.moveToPoint(CGPointMake(lineOffset / 2, lineOffset))
            triangleHeadPath.addLineToPoint(CGPointMake(lineOffset, 0))
            triangleHeadPath.addLineToPoint(CGPointMake(0, 0))
            triangleHeadPath.closePath()
            
            
            
            let box = CGPathGetBoundingBox(triangleHeadPath.CGPath)
            let center = CGPoint(x:CGRectGetMidX(box), y:CGRectGetMidY(box))
            
            let toOrigin = CGAffineTransformMakeTranslation(-center.x, -center.y)
            triangleHeadPath.applyTransform(toOrigin)
            
            let rotate = CGAffineTransformMakeRotation(-theta - CGFloat(M_PI / 2))
            triangleHeadPath.applyTransform(rotate)
            
            let fromOrigin = CGAffineTransformMakeTranslation(center.x, center.y)
            triangleHeadPath.applyTransform(fromOrigin)
            
            let translate = CGAffineTransformMakeTranslation(arrowHeadPoint.x - (lineOffset / 2), arrowHeadPoint.y - (lineOffset / 2))
            triangleHeadPath.applyTransform(translate)

            triangleHeadPath.fill()

            
            CGContextSetStrokeColorWithColor(context!, UIColor.blueColor().CGColor)
            CGContextSetFillColorWithColor(context!, UIColor.blueColor().CGColor)
            
            let yArrowPath = UIBezierPath()
            yArrowPath.moveToPoint(CGPointMake(frame.size.width / 2, frame.size.height / 2))
            yArrowPath.addLineToPoint(CGPointMake(frame.size.width / 2, arrowHeadPoint.y))
            yArrowPath.stroke()
            
            
            ///
            let negativeY = (arrowHeadPoint.y < (frame.size.height / 2)) ? true : false
            
            let yTriangleHeadPath = UIBezierPath()
            yTriangleHeadPath.moveToPoint(CGPointMake(lineOffset / 2, lineOffset))
            yTriangleHeadPath.addLineToPoint(CGPointMake(lineOffset, 0))
            yTriangleHeadPath.addLineToPoint(CGPointMake(0, 0))
            yTriangleHeadPath.closePath()
            
            
            //transformations for th X arrow like we did with the vector arrow
            let yBox = CGPathGetBoundingBox(yTriangleHeadPath.CGPath)
            let yCenter = CGPoint(x:CGRectGetMidX(yBox), y:CGRectGetMidY(yBox))
            
            let yToOrigin = CGAffineTransformMakeTranslation(-yCenter.x, -yCenter.y)
            yTriangleHeadPath.applyTransform(yToOrigin)
            
            let yRotate = CGAffineTransformMakeRotation(negativeY ? CGFloat(M_PI) : 0)
            yTriangleHeadPath.applyTransform(yRotate)
            
            let yFromOrigin = CGAffineTransformMakeTranslation(yCenter.x, yCenter.y)
            yTriangleHeadPath.applyTransform(yFromOrigin)
            
            let xxShift = (frame.size.width / 2) - (lineOffset / 2)
            let xyShift = arrowHeadPoint.y + (-0.5 * lineOffset)
            let yTranslate = CGAffineTransformMakeTranslation(xxShift, xyShift)
            yTriangleHeadPath.applyTransform(yTranslate)
            
            yTriangleHeadPath.fill()
            
            
            CGContextSetStrokeColorWithColor(context!, UIColor.redColor().CGColor)
            CGContextSetFillColorWithColor(context!, UIColor.redColor().CGColor)
            
            let xArrowPath = UIBezierPath()
            xArrowPath.moveToPoint(CGPointMake(frame.size.width / 2, frame.size.height / 2))
            xArrowPath.addLineToPoint(CGPointMake(arrowHeadPoint.x, frame.size.height / 2))
            xArrowPath.stroke()
            
            let xTriangleHeadPath = UIBezierPath()
            xTriangleHeadPath.moveToPoint(CGPointMake(lineOffset / 2, lineOffset))
            xTriangleHeadPath.addLineToPoint(CGPointMake(lineOffset, 0))
            xTriangleHeadPath.addLineToPoint(CGPointMake(0, 0))
            xTriangleHeadPath.closePath()
            
            let negativeX = (arrowHeadPoint.x < (frame.size.width / 2)) ? true : false
            
            //transformations for th X arrow like we did with the vector arrow
            let xBox = CGPathGetBoundingBox(xTriangleHeadPath.CGPath)
            let xCenter = CGPoint(x:CGRectGetMidX(xBox), y:CGRectGetMidY(xBox))
            
            let xToOrigin = CGAffineTransformMakeTranslation(-xCenter.x, -xCenter.y)
            xTriangleHeadPath.applyTransform(xToOrigin)
            
            let xRotate = CGAffineTransformMakeRotation(negativeX ? CGFloat(M_PI / 2) : CGFloat(M_PI / -2))
            xTriangleHeadPath.applyTransform(xRotate)
            
            let xFromOrigin = CGAffineTransformMakeTranslation(xCenter.x, xCenter.y)
            xTriangleHeadPath.applyTransform(xFromOrigin)
            
            let xShift = arrowHeadPoint.x + (-0.5 * lineOffset)
            let yShift = (frame.size.height / 2) - (lineOffset / 2)
            let xTranslate = CGAffineTransformMakeTranslation(xShift, yShift)
            xTriangleHeadPath.applyTransform(xTranslate)
            
            xTriangleHeadPath.fill()
        }
        
        
//         let path1 = UIBezierPath(roundedRect: <#T##CGRect#>, cornerRadius: <#T##CGFloat#>)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let t = touches.first
        let point = t?.locationInView(self)
        arrowHeadPoint = point
        
        notifyDelegate()
        
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let t = touches.first
        let point = t?.locationInView(self)
        arrowHeadPoint = point
        
        notifyDelegate()
        
        setNeedsDisplay()
    }
    
    func notifyDelegate() {
        if let donutController = directionDelegate {
            if let arrowHeadPoint = arrowHeadPoint {
                let x = arrowHeadPoint.x - (frame.size.width / 2)
                let y = (frame.size.height / 2) - arrowHeadPoint.y
                donutController.newPoint(CGPointMake(x, y))
            }
        }
    }
}
