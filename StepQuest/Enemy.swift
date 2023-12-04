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
    var imageFile: String = "monster101"
    var health: Int = 100
    var moveSpeed: CGFloat = 500.0
    var currentWaypoint: Int = 1
    //var currentPosition: CGPoint?
    var path: [SKNode]
    var currentNodeIndex: Int = 0

    
    init(path: [SKNode]) {
        let texture = SKTexture(imageNamed: imageFile)
        self.path = path
        super.init(texture: texture, color: .clear, size: texture.size())
        
        
        self.position = getStartPos() ?? CGPointZero
        
        self.zPosition = 2.0
        
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
    
    func takeDamage() {
        
    }
    
    func die() {
        
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

        // Check if the enemy has reached the waypoint
        if self.position == goalPos {
            if currentWaypoint < path.count - 1 {
                currentWaypoint += 1  // Move to the next waypoint
            } else {return}
            
            
        }
    }
}

