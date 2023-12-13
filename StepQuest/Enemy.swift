//
//  Enemy.swift
//  StepQuest
//
//  Created by Louis Kürbis on 29/11/2023.
//

import Foundation
import SpriteKit
import GameplayKit

class Enemy: SKSpriteNode {
    var path: [SKNode]
    var imageFile: String = ""
    var health: Int = 0
    var moveSpeed: CGFloat = 0
    
    var currentWaypoint: Int = 1
    var currentNodeIndex: Int = 0

    
    init(path: [SKNode], imageFile: String, health: Int, moveSpeed: CGFloat) {
        self.imageFile = imageFile
        self.health = health
        self.moveSpeed = moveSpeed
        
        let texture = SKTexture(imageNamed: imageFile)
        self.path = path
        super.init(texture: texture, color: .clear, size: texture.size())
        
        
        self.position = getStartPos() ?? CGPointZero
        self.zPosition = 2.0
        
        animateWalk()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getStartPos() -> CGPoint? {
            if let firstNode = path.first {
                print("first node found")
                return firstNode.position
            } else {
                print("first node not found")
                // Return nil or a default value if the array is empty
                return nil
            }
        }
    
    func loadWalkTextures() -> [SKTexture] {
        var textures: [SKTexture] = []
        textures.append(SKTexture(imageNamed: imageFile))
        for i in 1...3 {
            let textureName = "\(imageFile)\(i)"
            textures.append(SKTexture(imageNamed: textureName))
        }
        return textures
    }
    
    func animateWalk() {
        let textures = loadWalkTextures()
        let animation = SKAction.animate(with: textures, timePerFrame: 0.1)
        let walkAnimation = SKAction.repeatForever(animation)
        self.run(walkAnimation)
    }

    func setSpriteDirection() {
        let goal = path[currentWaypoint].position
        let monster = position
        //Checks if monsters position is right of their goal waypoint
        if goal.x <= monster.x {
            //Flip sprite left
            self.xScale = -abs(self.xScale)
        } else {
            //Flip sprite right
            self.xScale = abs(self.xScale)
        }
    }
    
    func getGoalDistance() -> CGFloat {
        let point1 = self.position
        let point2 = path[currentWaypoint].position
        
        let dx = point1.x - point2.x
        let dy = point1.y - point2.y
        return sqrt(dx * dx + dy * dy)
    }
    
    func takeDamage(damage: Int) {
        health -= damage
        if health <= 0 {
            die()
        } else {
            // Make enemy flash red takin damage
            let originalColor = self.color
            let redAction = SKAction.colorize(with: .red, colorBlendFactor: 1.0, duration: 0.1)
            let originalColorAction = SKAction.colorize(with: originalColor, colorBlendFactor: 0.0, duration: 0.1)
            let flashSequence = SKAction.sequence([redAction, originalColorAction])
            self.run(flashSequence)
        }
    }
    
    func die() {
        removeFromParent()
    }
    
    func initPos() {
        
    }
    
    func move(deltaTime: TimeInterval) {
        let goalPos = path[currentWaypoint].position
        
        // Calculate the amount to move this frame
        let amountToMove = CGFloat(moveSpeed) * CGFloat(deltaTime)

        // Move in x direction
        if self.position.x < goalPos.x {
            self.position.x += min(amountToMove, goalPos.x - self.position.x)
        } else if self.position.x > goalPos.x {
            self.position.x -= min(amountToMove, self.position.x - goalPos.x)
        }

        // Move in y direction
        if self.position.y < goalPos.y {
            self.position.y += min(amountToMove, goalPos.y - self.position.y)
        } else if self.position.y > goalPos.y {
            self.position.y -= min(amountToMove, self.position.y - goalPos.y)
        }

        setSpriteDirection()
        
        // Check if the enemy has reached the waypoint
        if self.position == goalPos {
            if currentWaypoint < path.count - 1 {
                currentWaypoint += 1  // Move to the next waypoint
            } else {
                removeFromParent()
                // Implement code later to end level/ or something
            }
            
            
        }
    }
    
    deinit {
        print("Enemy instance is being deallocated")
    }
}

