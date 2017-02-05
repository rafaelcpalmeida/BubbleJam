//
//  Bubble.swift
//  BubbleJam
//
//  Created by Rafael Almeida on 04/02/17.
//  Copyright © 2017 Rafael Almeida. All rights reserved.
//

import Foundation
import SpriteKit

class Bubble {
    
    var size: Int
    var x: Int
    var y: Int
    var path: CGMutablePath = CGMutablePath()
    var bubble: SKShapeNode
    var color: UIColor = .black
    var duration: TimeInterval
    
    init(width: CGFloat, height: CGFloat) {
        self.size = Int(arc4random_uniform(UInt32((Int(width*0.15) + Int(width*0.02)) - (Int(width*0.02))))) + (Int(width*0.02))
        
        self.x = Int(arc4random_uniform(UInt32((width - CGFloat(size)) - CGFloat(size))) + UInt32(size))
        
        self.y = Int(arc4random_uniform(UInt32((height - CGFloat(size)) - CGFloat(size))) + UInt32(size))
        
        self.duration = Double(arc4random_uniform(5) + 1)
        
        self.path.addArc(center: CGPoint.zero,
                    radius: CGFloat(size),
                    startAngle: 0,
                    endAngle: CGFloat.pi * 2,
                    clockwise: true)
        
        self.bubble = SKShapeNode(path: path)
        self.color = self.getRandomColor()
        
        bubble.position = CGPoint(x: x, y: y)
        bubble.setScale(1.0)
        bubble.strokeColor = color
        bubble.fillColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
