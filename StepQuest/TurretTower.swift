//
//  Tower.swift
//  StepQuest
//
//  Created by Max Hakin on 28/11/2023.
//

import Foundation
import SpriteKit

class TurretTower: Tower {
    enum TowerLevel {
        case level1
        case level2
        case level3

        var stats: (range: CGFloat, attackSpeed: TimeInterval, damage: Int, baseImage: String, topImage: String, projectileType: String) {
            switch self {
                case .level1:
                    return (400, 10, 10, "towerBase1", "turretGun1", "bullet1")
                case .level2:
                    return (500, 7, 20, "towerBase2", "turretGun2", "bullet2")
                case .level3:
                    return (600, 5, 30, "towerBase3", "turretGun3", "bullet3")
            }
        }
    }
    var level: TowerLevel
    
    
    
    init(levelString: String, enemyHandler: EnemyHandler) {
        switch levelString {
            case "level1":
                level = .level1
            case "level2":
                level = .level2
            case "level3":
                level = .level3
            default:
                level = .level1
        }
        
        let stats = level.stats
        super.init(enemyHandler: enemyHandler)
        
        range = stats.range
        attackSpeed = stats.attackSpeed
        damage = stats.damage
        baseImage = stats.baseImage
        topImage = stats.topImage
        projectileType = stats.projectileType
        
        makeTower()
        createRangeCircle()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
}

