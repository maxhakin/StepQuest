//
//  Tower.swift
//  StepQuest
//
//  Created by Max Hakin on 08/12/2023.
//

import Foundation
import SpriteKit

class Tower: SKNode {
    var range: CGFloat = 0
    var attackSpeed: TimeInterval = 0
    var damage: Int = 0
    var rotationSpeed: Float = 2
    
    var baseImage: String = ""
    var topImage: String = ""
    var base: SKSpriteNode?
    var top: SKSpriteNode?
    var projectileType: String?
    
    var towerType: String = ""
    var enemyHandler: EnemyHandler
    
    var scale: CGFloat = 0.65
    var lastAttackTime: TimeInterval = 0
    
    var rangeCircle: SKShapeNode?
    
    
    
    init(enemyHandler: EnemyHandler) {
        self.enemyHandler = enemyHandler
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attack(projectileHandler: ProjectileHandler) {
        // Check if enough time has passed since the last attack
        let currentTime = CACurrentMediaTime()
        if currentTime - lastAttackTime >= attackSpeed {
            // Find a target enemy in range
            if let targetEnemy = getTarget() {
                // Create a projectile and add it to the handler
                projectileHandler.makeProjectile(projectileType: projectileType!, startLocation: getPositionInScene(), target: targetEnemy)
                // Update the last attack time
                lastAttackTime = currentTime
            }
        }
    }
    
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
    
    // Create visual range of tower for debugging
    func createRangeCircle() {
        // Remove existing circle if there is any
        rangeCircle?.removeFromParent()

        let circle = SKShapeNode(circleOfRadius: range)
        circle.fillColor = SKColor.blue.withAlphaComponent(0.3)
        circle.strokeColor = SKColor.blue
        circle.lineWidth = 1
        circle.zPosition = 2
        addChild(circle)

        rangeCircle = circle
    }
    
    
    func upgrade(upgradeType: String) {
        print ("upgrade function called")
    }
    
    func getTowerType() -> String {
        return towerType
    }
    
    func getTowerData() -> TowerData {
        let point = getPositionInScene()
        let xValue = Double(point.x)
        let yValue = Double(point.y)
        
        return TowerData(type: towerType, xPos: xValue, yPos: yValue)
        
    }
    
    // Find furthest along target in range
    func getTarget() -> Enemy? {
        var targetEnemy: Enemy?
        var furthestWaypoint = -1
        var closestDistance = CGFloat.infinity
        
        // Cycle through all possible enemies
        for enemy in enemyHandler.enemies {
            let distance = distanceTo(enemy: enemy)
            //Check if target is within range of the tower
            if distance <= range {
                let waypointIndex = enemy.currentWaypoint
                let distanceIndex = enemy.getGoalDistance()
                
                //Check if enemy is furthest along the path, set target enemy if it is
                if waypointIndex >= furthestWaypoint {
                    furthestWaypoint = waypointIndex
                    if closestDistance >= distanceIndex {
                        targetEnemy = enemy
                    }
                }
            }
        }
        furthestWaypoint = -1
        closestDistance = CGFloat.infinity
        return targetEnemy
    }
    
    func distanceTo(enemy: Enemy) -> CGFloat {
        let towerPositionInScene = getPositionInScene()
        
        //Calculate the distance to the enemy using pythagoras thereom
        let dx = enemy.position.x - towerPositionInScene.x
        let dy = enemy.position.y - towerPositionInScene.y
        return sqrt(dx * dx + dy * dy)
    }
    
    func getPositionInScene() -> CGPoint {
        // Convert the tower's position to the scene's coordinate system
        guard let scene = self.scene else { return CGPoint.zero }
        let towerPositionInScene = scene.convert(self.position, from: self.parent!)
        return towerPositionInScene
    }
    
    // rotate turret sprite to face the target enemy
    func rotateTurret(deltaTime: TimeInterval) {
        guard let targetEnemy = getTarget() else { return }
        let turretPos = parent!.convert(self.position, to: scene!)
        let turretAngle = angleToTarget(from: turretPos, to: targetEnemy.position)
        let currentAngle = top!.zRotation
        let angleDifference = shortestAngleBetween(angle1: currentAngle, angle2: turretAngle)
            
        // Rotate the turret by a fraction of the difference, based on rotationSpeed and deltaTime
        top!.zRotation += angleDifference * CGFloat(rotationSpeed) * CGFloat(deltaTime)
    }
    
    // Calculates and returns the angle between the tower and the target enemy
    func angleToTarget(from turretPosition: CGPoint, to targetPosition: CGPoint) -> CGFloat {
        let deltaX = targetPosition.x - turretPosition.x
        let deltaY = targetPosition.y - turretPosition.y
        return atan2(deltaY, deltaX)
    }
    
    // Assess which direction to rotate depending on what would be the smaller angle
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
    
    func update(deltaTime: TimeInterval, projectileHandler: ProjectileHandler) {
        rotateTurret(deltaTime: deltaTime)
        attack(projectileHandler: projectileHandler)
    }
    
    // For use in debugging to check tower is deinitialised when deleted
    deinit {
        print("Tower has been removed")
    }
    
    
    
}

