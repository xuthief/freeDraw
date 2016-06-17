//
//  SmoothedBIView.swift
//  freeDraw
//
//  Created by xuthief on 16/6/17.
//  Copyright © 2016年 xuthief. All rights reserved.
//

import UIKit

class SmoothedBIView: UIView {

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
            if pts.count == 5 {
                let pts_3 = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0); // move the endpoint to the middle of the line joining the second control point of the first Bezier segment and the first control point of the second Bezier segment
                let pts_4 = pts[4]
                path.moveToPoint(pts[0])
                path.addCurveToPoint(pts_3, controlPoint1: pts[1], controlPoint2: pts[2])
                self.setNeedsDisplay()
                pts = [pts_3, pts_4]
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.drawBitmap()
        self.setNeedsDisplay()
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
