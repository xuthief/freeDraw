//
//  CachedLIView.swift
//  freeDraw
//
//  Created by xuthief on 16/6/16.
//  Copyright © 2016年 xuthief. All rights reserved.
//

import UIKit

class CachedLIView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var path : UIBezierPath
    var increamentalImage : UIImage?
    
    required init?(coder aDecoder: NSCoder) {
        path = UIBezierPath.init()
        path.lineWidth = 2.0
        super.init(coder: aDecoder)
        self.multipleTouchEnabled = true
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override func drawRect(rect: CGRect) {
        if (increamentalImage != nil) {
            increamentalImage!.drawInRect(rect)
        }
        path.stroke()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.first != nil {
            let touch = touches.first!
            path.moveToPoint(touch.locationInView(self))
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.first != nil {
            let touch = touches.first!
            path.addLineToPoint(touch.locationInView(self))
            self.setNeedsDisplay()
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.first != nil {
            let touch = touches.first!
            path.addLineToPoint(touch.locationInView(self))
            self.drawBitmap()
            self.setNeedsDisplay()
            path.removeAllPoints()
        }
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
