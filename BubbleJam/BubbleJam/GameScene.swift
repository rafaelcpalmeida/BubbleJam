//
//  GameScene.swift
//  BubbleJam
//
//  Created by Rafael Almeida on 01/02/17.
//  Copyright © 2017 Rafael Almeida. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

let gameLayer = SKNode()
let ballsLayer = SKNode()
let pontuationLabel = SKLabelNode(fontNamed: "Arial")
var pontuation = 0

class GameScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = .white
        
        addChild(gameLayer)
        
        ballsLayer.position = CGPoint(x: 0, y: 0)
        gameLayer.addChild(ballsLayer)
        
        pontuationLabel.text = "Pontuation: 0"
        pontuationLabel.fontSize = 20
        pontuationLabel.fontColor = .black
        pontuationLabel.horizontalAlignmentMode = .left
        pontuationLabel.position = CGPoint(x: 5.0, y: (self.size.height-(CGFloat(pontuationLabel.fontSize)+1)))
        
        gameLayer.addChild(pontuationLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        /*DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(i)) {
         self.addBall()
         i += 1
         }*/
        
        var i = 1
        
        while(ballsLayer.children.count < 10) {
            self.addBall(i: i)
            i += 1
        }
        
        //self.removeBalls()
        
        //second = 1000000
        //usleep(11500000)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node: SKNode = self.atPoint(location)
            
            if node.name == "bubble" {
                pontuation += 1
                pontuationLabel.text = "Pontuation: \(pontuation)"
                node.removeFromParent()
            } else {
                
            }
        }
    }
    
    func addBall(i: Int) {
        let bub = Bubble(width: size.width, height: size.height)
        
        bub.bubble.name = "bubble"
        
        ballsLayer.addChild(bub.bubble)
        
        bub.bubble.run(
            SKAction.sequence([
                SKAction.wait(forDuration: bub.duration),
                    SKAction.removeFromParent()
                ])
        )
    }
}
