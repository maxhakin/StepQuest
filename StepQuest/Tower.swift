//
//  Tower.swift
//  StepQuest
//
//  Created by Louis Kürbis on 08/12/2023.
//

import Foundation
import SpriteKit

class Tower: SKNode {
    var range: CGFloat = 0
    var attackSpeed: Float = 0
    var damage: Int = 0
    var rotationSpeed: CGFloat = 2
    
    var baseImage: String = ""
    var topImage: String = ""
    var base: SKSpriteNode?
    var top: SKSpriteNode?
    
    var towerType: String = ""
    var towerLocation: CGPoint?
    var target: Enemy?
    
    var scale: CGFloat = 0.65
    
    var rangeCircle: SKShapeNode?
    
    
    
    override init() {
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //func attack(target: enemy) {
        
    //}
    
    func makeTower() {
        base = SKSpriteNode(imageNamed: baseImage)
        top = SKSpriteNode(imageNamed: topImage)
        
        base?.zPosition = 2
        top?.zPosition = 3
        
        base?.setScale(scale)
        top?.setScale(scale)
        
        addChild(base!)
        addChild(top!)
    
    }
    
    func createRangeCircle() {
            rangeCircle?.removeFromParent() // Remove existing circle if any

            let circle = SKShapeNode(circleOfRadius: range)
            circle.fillColor = SKColor.blue.withAlphaComponent(0.3) // Semi-transparent blue
            circle.strokeColor = SKColor.blue
            circle.lineWidth = 1
            circle.zPosition = 2  // Ensure it's below the turret
            addChild(circle)

            rangeCircle = circle
        }
    
    
    func upgrade() {
        
    }
    
    func getTarget(enemies: [Enemy]) -> Enemy? {
        var targetEnemy: Enemy?
        var furthestWaypoint = -1
        var closestDistance = CGFloat.infinity

        for enemy in enemies {
            let distance = distanceTo(enemy: enemy)
            print(distance)
            //Check if target is within range of the tower
            if distance <= range {
                let waypointIndex = enemy.currentWaypoint
                let distanceIndex = enemy.getGoalDistance()
                //print("Enemy in range")
                
                //Check if enemy is further along the path than other enemies, set the enemy as target enemy if it is
                if waypointIndex >= furthestWaypoint {
                    furthestWaypoint = waypointIndex
                    if closestDistance >= distanceIndex {
                        targetEnemy = enemy
                        print("target set", (targetEnemy?.position.x)!, (targetEnemy?.position.y)!)
                    }
                }
            }
        }
        
        furthestWaypoint = -1
        closestDistance = CGFloat.infinity
        return targetEnemy
    }
    
    func distanceTo(enemy: Enemy) -> CGFloat {
        // Convert the tower's position to the scene's coordinate system
        guard let scene = self.scene else { return CGFloat.infinity }
        let towerPositionInScene = scene.convert(self.position, from: self.parent!)
        
        //print(towerPositionInScene)
        
        //Calculate the distance to the enemy using pythagoras thereom
        let dx = enemy.position.x - towerPositionInScene.x
        let dy = enemy.position.y - towerPositionInScene.y
        return sqrt(dx * dx + dy * dy)
    }
    
    func targetInRange() {
        
    }
    
    func rotateTurret(enemies: [Enemy], deltaTime: TimeInterval) {
        guard let targetEnemy = getTarget(enemies: enemies) else { return }
        let turretPos = parent!.convert(self.position, to: scene!)
        let turretAngle = angleToTarget(from: turretPos, to: targetEnemy.position)
        let currentAngle = top!.zRotation
        let angleDifference = shortestAngleBetween(angle1: currentAngle, angle2: turretAngle)
            
        // Rotate the turret by a fraction of the difference, based on rotationSpeed and deltaTime
        top!.zRotation += angleDifference * CGFloat(rotationSpeed) * CGFloat(deltaTime)
    }
    
    func angleToTarget(from turretPosition: CGPoint, to targetPosition: CGPoint) -> CGFloat {
        let deltaX = targetPosition.x - turretPosition.x
        let deltaY = targetPosition.y - turretPosition.y
        return atan2(deltaY, deltaX)
    }
    
    func shortestAngleBetween(angle1: CGFloat, angle2: CGFloat) -> CGFloat {
        var angle = (angle2 - angle1).truncatingRemainder(dividingBy: 2 * .pi)
        
        //Check if angle is greater than half a circle, if so the path is shorter to rotate in the opposite direction 
        if angle >= .pi {
            angle -= 2 * .pi
        } else if angle <= -.pi {
            angle += 2 * .pi
        }
        return angle
    }
    
    func erase() {
        
    }
    
    func update(enemies: [Enemy], deltaTime: TimeInterval) {
        rotateTurret(enemies: enemies, deltaTime: deltaTime)
    }
    
    func render() {
        
    }
    
    
    
}

