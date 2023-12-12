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

    init(gameScene: GameScene) {
        self.gameScene = gameScene
        towerPlaces = gameScene.getTowerPlaces()
    }

    func addTurretTower(at place: SKShapeNode, levelString: String) {
        if !isTower(at: place) {
            let newTower = TurretTower(placeNode: place, levelString: levelString)
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
            tower.update(enemies: enemies, deltaTime: deltaTime)
        }
    }

}
