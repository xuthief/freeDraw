//
//  BezierInterpView.swift
//  freeDraw
//
//  Created by xuthief on 16/6/16.
//  Copyright © 2016年 xuthief. All rights reserved.
//

import UIKit

class BezierInterpView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    let path : UIBezierPath
    var increamentalImage : UIImage?
    var pts : [CGPoint]
    
    required init?(coder aDecoder: NSCoder) {
        path = UIBezierPath.init()
        path.lineWidth = 2.0
        pts = []
        super.init(coder: aDecoder)
        self.multipleTouchEnabled = true
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override func drawRect(rect: CGRect) {
        increamentalImage?.drawInRect(rect)
        path.stroke()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.first != nil {
            let touch = touches.first!
            pts.removeAll()
            pts.append(touch.locationInView(self))
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.first != nil {
            let touch = touches.first!
            pts.append(touch.locationInView(self))
            if pts.count == 4 {
                path.moveToPoint(pts[0])
                path.addCurveToPoint(pts[3], controlPoint1: pts[1], controlPoint2: pts[2])
                self.setNeedsDisplay()
                pts.removeAll()
                pts.append(path.currentPoint)
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.drawBitmap()
        self.setNeedsDisplay()
        pts.removeAll()
        pts.append(path.currentPoint)
        path.removeAllPoints()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if touches != nil {
            self.touchesEnded(touches!, withEvent: event)
        }
    }
    
    func drawBitmap() {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0.0)
        UIColor.blackColor().setStroke()
        if increamentalImage == nil {
            let rectPath = UIBezierPath.init(rect: self.bounds)
            UIColor.whiteColor().setFill()
            rectPath.fill()
        }
        increamentalImage?.drawAtPoint(CGPointZero)
        path.stroke()
        increamentalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
