//
//  TowerHandler.swift
//  StepQuest
//
//  Created by Louis Kürbis on 07/12/2023.
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
            let turretTower = TurretTower(levelString: levelString, enemyHandler: enemyHandler)
            towers.append(turretTower)
            place.addChild(turretTower)
            print("tower placed")
        }
    }
    
    func addMissileTower(at place: SKShapeNode, levelString: String) {
        if !isTower(at: place) {
            let missileTower = MissileTower(levelString: levelString, enemyHandler: enemyHandler)
            towers.append(missileTower)
            place.addChild(missileTower)
            print("tower placed")
        }
    }
    
    func upgradeTower(at place: SKShapeNode) {
        
    }
    
    func deleteTower(at place: SKShapeNode) {
        
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
            tower.update(deltaTime: deltaTime, projectileHandler: projectileHandler)
        }
    }

}
