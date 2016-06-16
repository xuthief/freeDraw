//
//  LinerInterpView.swift
//  freeDraw
//
//  Created by xuthief on 16/6/14.
//  Copyright © 2016年 xuthief. All rights reserved.
//

import UIKit

class LinerInterpView: UIView {

    let path : UIBezierPath = UIBezierPath.init();
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.multipleTouchEnabled = true
        self.backgroundColor = UIColor.whiteColor()
        path.lineWidth = 2;
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        UIColor.blackColor().setStroke()
        path.stroke()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let p = touch.locationInView(self)
        path.moveToPoint(p)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let p = touch.locationInView(self)
        path.addLineToPoint(p)
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.touchesEnded(touches!, withEvent: event)
    }    
}
