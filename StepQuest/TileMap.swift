//
//  TileMap.swift
//  StepQuest
//
//  Created by Louis Kürbis on 03/12/2023.
//

import Foundation
import SpriteKit

extension SKTileMapNode {
    
    func getTile(location: CGPoint) -> SKTileDefinition {
        // Convert the location to the tile tileMap's coordinate system
        let col = tileColumnIndex(fromPosition: location)
        let row = tileRowIndex(fromPosition: location)

        // Return the tile definition at this column and row
        return tileDefinition(atColumn: col, row: row)!
    }
    
    func setTileTower(at location: CGPoint, tower: TurretTower) {
        tower.position = getTileCentre(at: location)
        self.addChild(tower)
        
    }
    
    
    func getTileTower(at location: CGPoint) -> String {
        
        
        
        let tile = getTile(location: location)
        if let userData = tile.userData, userData["towerType"] as? String != nil {
            // Return tower type
            return userData["towerType"] as! String
        }
        return ""
    }
    
    func getTileCentre(at location: CGPoint) -> CGPoint {
        let col = tileColumnIndex(fromPosition: location)
        let row = tileRowIndex(fromPosition: location)
        
        return centerOfTile(atColumn: col, row: row)
    }
}


