//
//  GraphView.swift
//  Pedometer
//
//  Created by Bryan  Miller on 7/19/16.
//  Copyright © 2016 Bryan  Miller. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    var noOfSteps :[NSNumber] = [NSNumber]()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func plot(noOfSteps :[NSNumber]) {
        
        self.noOfSteps = noOfSteps
        self.setNeedsDisplay()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        var x = 15
        
        for step in self.noOfSteps {
            
            UIColor.blueColor().setFill()
            let bar = UIBezierPath(rect: CGRect(x: x, y: Int(self.bounds.height - 10), width: 30, height: -1 * step.integerValue/200))
            
            //space between 
            
            x += Int(self.frame.size.width) / self.noOfSteps.count
            
            
            
           
            
            bar.fill()
            
            let label : String = String (step)
            
             label.drawInRect(CGRect(x:x-50,y: 400, width:100, height:20), withAttributes:nil)
            
        }
        
        
        
    }
    
    
}
