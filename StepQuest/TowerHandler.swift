//
//  TowerHandler.swift
//  StepQuest
//
//  Created by Max Hakin on 07/12/2023.
//

import Foundation
import SpriteKit

class TowerHandler {
    
    var towerPlaces: [SKShapeNode] = []
    var towers: [Tower] = []
    weak var gameScene: GameScene?
    var projectileHandler: ProjectileHandler
    var enemyHandler: EnemyHandler

    init(gameScene: GameScene) {
        self.gameScene = gameScene
        towerPlaces = gameScene.getTowerPlaces()
        
        self.projectileHandler = gameScene.projectileHandler!
        self.enemyHandler = gameScene.enemyHandler!
    }

    func addTurretTower(at place: SKShapeNode, levelString: String) {
        if !isTower(at: place) {
            let newTower = TurretTower(levelString: levelString, enemyHandler: enemyHandler)
            towers.append(newTower)
            place.addChild(newTower)
            print("tower placed")
        }
    }
    
    func addMissileTower(at place: SKShapeNode, levelString: String) {
        if !isTower(at: place) {
            let newTower = MissileTower(levelString: levelString, enemyHandler: enemyHandler)
            towers.append(newTower)
            place.addChild(newTower)
            print("tower placed")
        }
    }
    
    func upgradeTower(at place: SKShapeNode) {
        if let index = getTower(at: place) {
            let towerType = towers[index].towerType
            deleteTower(at: place)
            
            if towerType == "turret1" {
                addTurretTower(at: place, levelString: "turret2")
            }
            else if towerType == "turret2" {
                addTurretTower(at: place, levelString: "turret3")
            }
            else if towerType == "missile1" {
                addMissileTower(at: place, levelString: "missile2")
            }
            else if towerType == "missile2" {
                addMissileTower(at: place, levelString: "missile3")
            }
        }
    }
    
    func deleteTower(at place: SKShapeNode) {
        if let index = getTower(at: place) {
            // Remove children from tower
            towers[index].removeAllChildren()
            // Remove the tower from the scene if necessary
            towers[index].removeFromParent()
            
            // Remove the tower from the array
            towers.remove(at: index)
        }
    }
    
    func getTower(at place: SKShapeNode) -> Optional<Int> {
        // Find the index of the tower that matches the given node
        return towers.firstIndex(where: { $0.parent === place })
    }
    
    func isTower(at place: SKShapeNode) -> Bool {
        if place.children.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    func update(deltaTime: TimeInterval) {
        for tower in towers {
            if tower.parent != nil {
                tower.update(deltaTime: deltaTime, projectileHandler: projectileHandler)
            }
        }
    }

}
