//
//  TowerHandler.swift
//  StepQuest
//
//  Created by Louis Kürbis on 07/12/2023.
//

import Foundation
import SpriteKit

class TowerHandler {
    
    var towers: [TurretTower] = []
    weak var gameScene: GameScene?
    weak var tileMap: SKTileMapNode?

    init(gameScene: GameScene, tileMap: SKTileMapNode) {
        self.gameScene = gameScene
        self.tileMap = tileMap
        tileMap.childNode(withName: <#T##String#>)
    }

    func addTower(at location: CGPoint) {
        let tileCentreLocation = tileMap!.getTileCentre(at: location)
        let newTower = TurretTower(at: tileCentreLocation, map: tileMap!)
        towers.append(newTower)
        gameScene?.addChild(newTower)
    }

}
