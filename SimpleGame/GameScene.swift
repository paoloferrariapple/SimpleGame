//
//  GameScene.swift
//  SimpleGame
//
//  Created by user on 04/07/22.
//

import SpriteKit

class GameScene: SKScene {
    
    var player: SKSpriteNode!
    var enemy: SKSpriteNode!
    var leftMove: SKSpriteNode!
    var leftPressing: Bool = false
    var rightMove: SKSpriteNode!
    var rightPressing: Bool = false
    var jumpMove: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        //Visual Ground creation
        let tempGround = SKSpriteNode(imageNamed: "Ground")
        let groundRadius = tempGround.frame.width / 2.0
        
        for i in stride(from: groundRadius, to: (scene?.frame.width)! + groundRadius, by: tempGround.frame.width) {
            let ground = SKSpriteNode(imageNamed: "Ground")
            ground.position = CGPoint(x: i, y: 50)
            ground.zPosition = 0
            addChild(ground)
        }
        
        //Player creation
        player = SKSpriteNode(imageNamed: "Character")
        player.position = CGPoint(x: scene!.frame.width / 2, y: scene!.frame.height / 2)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.restitution = 0.5
        
        addChild(player)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 50 + groundRadius, left: 0, bottom: 0, right: 0)))
        
        //move buttons
        leftMove = SKSpriteNode (imageNamed: "Arrow")
        leftMove.position = CGPoint(x:80, y:50)
        leftMove.size = CGSize (width: 55, height: 55)
        leftMove.name = "Left"
        leftMove.zRotation = .pi / 2
        leftMove.zPosition = 10
        addChild(leftMove)
        
        rightMove = SKSpriteNode (imageNamed: "Arrow")
        rightMove.position = CGPoint(x:160, y:50)
        rightMove.size = CGSize (width: 55, height: 55)
        rightMove.name = "Right"
        rightMove.zRotation = -.pi / 2
        rightMove.zPosition = 10
        addChild(rightMove)
        
        
        rightMove = SKSpriteNode (imageNamed: "Arrow")
        rightMove.position = CGPoint(x: (scene?.frame.width)!-80, y:50)
        rightMove.size = CGSize (width: 55, height: 55)
        rightMove.name = "Jump"
        rightMove.zPosition = 10
        addChild(rightMove)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if (node.name == "Left") {
                leftPressing = true
                rightPressing = false
            } else if (node.name == "Right") {
                rightPressing = true
                leftPressing = false
            } else if (node.name == "Jump") {
                for i in (5...17).reversed() {
                    player.run(SKAction.sequence([SKAction.move(by: CGVector(dx: 0, dy: i), duration: 0.2)]))
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if (node.name == "Left") {
                leftPressing = false
            } else if (node.name == "Right") {
                rightPressing = false
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if leftPressing {
            player.run(SKAction.sequence([SKAction.move(by: CGVector(dx: -3, dy: 0), duration: 0.1)]))
        }
        
        if rightPressing {
            player.run(SKAction.sequence([SKAction.move(by: CGVector(dx: 3, dy: 0), duration: 0.1)]))
        }
        
        let rand = Int.random(in: 5...10)
        if rand == 10 {
            enemy = SKSpriteNode(imageNamed: "Enemy")
            enemy.position = CGPoint(x: 25 + enemy.frame.width, y: scene!.frame.height - enemy.frame.height)
            enemy.scale(to: CGSize(width: 35, height: 35))
            enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
            enemy.physicsBody?.restitution = 0.8
            enemy.physicsBody?.friction = 0
            addChild(enemy)
            enemy.run(SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.removeFromParent()]))
        }
    }
}
