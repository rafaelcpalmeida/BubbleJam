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
let bubblesLayer = SKNode()
var bubbles: [Bubble] = []
let pontuationLabel = SKLabelNode(fontNamed: "Arial")
let gameOverLabel = SKLabelNode(fontNamed: "Arial")
var pontuation = 0
var gameOver = false
var gameStarted = false
let numberOfBubbles = 1

class GameScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = .white
        
        addChild(gameLayer)
        
        bubblesLayer.position = CGPoint(x: 0, y: 0)
        gameLayer.addChild(bubblesLayer)
        
        placeLabelTopLeft()
        
        gameLayer.addChild(pontuationLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        while(bubblesLayer.children.count < numberOfBubbles) {
            self.addBall()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node: SKNode = self.atPoint(location)
            
            if node.name == "bubble" && !gameOver {
                if !gameStarted {
                    gameStarted = true
                }
                
                pontuation += bubbles[0].points
                print(bubbles[0].points)
                pontuationLabel.text = "Pontuation: \(pontuation)"
                
                node.removeFromParent()
                bubbles.remove(at: 0)
            } else if !gameOver {
                gameOver = true
                
                for case let bubble as SKShapeNode in bubblesLayer.children {
                    bubble.removeAllActions()
                }
                
                placeLabelGameOver()
            } else if gameOver {
                for case let bubble as SKShapeNode in bubblesLayer.children {
                    bubble.removeFromParent()
                }
                
                gameOverLabel.removeFromParent()
                pontuation = 0
                placeLabelTopLeft()
                gameOver = false
                
                addBall()
            }
        }
    }
    
    func addBall() {
        let bub = Bubble(width: size.width, height: size.height, currentPontuation: pontuation)
        
        bub.bubble.name = "bubble"
        
        bubblesLayer.addChild(bub.bubble)
        
        bubbles.append(bub)
        
        if gameStarted && !gameOver {
            bub.bubble.run(
                SKAction.sequence([
                    SKAction.wait(forDuration: bub.duration),
                        SKAction.removeFromParent()
                    ])
            )
        }
    }
    
    func placeLabelTopLeft() {
        pontuationLabel.text = "Pontuation: 0"
        pontuationLabel.fontSize = 20
        pontuationLabel.fontColor = .black
        pontuationLabel.horizontalAlignmentMode = .left
        pontuationLabel.position = CGPoint(x: 5.0, y: (self.size.height-(CGFloat(pontuationLabel.fontSize)+1)))
    }
    
    func placeLabelGameOver() {
        gameOverLabel.text = "Game Over!"
        gameOverLabel.fontSize = 40
        gameOverLabel.fontColor = .black
        gameOverLabel.horizontalAlignmentMode = .center
        gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        pontuationLabel.horizontalAlignmentMode = .center
        pontuationLabel.position = CGPoint(x: self.frame.midX, y: (self.frame.midY-(CGFloat(pontuationLabel.fontSize)+5)))
        
        gameLayer.addChild(gameOverLabel)
    }
}
