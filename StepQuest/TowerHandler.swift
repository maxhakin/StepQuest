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

    init(gameScene: GameScene, projectileHandler: ProjectileHandler) {
        self.gameScene = gameScene
        towerPlaces = gameScene.getTowerPlaces()
        
        self.projectileHandler = projectileHandler
    }

    func addTurretTower(at place: SKShapeNode, levelString: String, enemies: [Enemy]) {
        if !isTower(at: place) {
            let newTower = TurretTower(levelString: levelString, enemies: enemies)
            towers.append(newTower)
            place.addChild(newTower)
            print("tower placed")
        }
    }
    
    func isTower(at place: SKShapeNode) -> Bool {
        if place.children.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    func update(enemies: [Enemy], deltaTime: TimeInterval) {
        for tower in towers {
            tower.update(enemies: enemies, deltaTime: deltaTime, projectileHandler: projectileHandler)
        }
    }

}
