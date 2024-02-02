//
//  MissileTower.swift
//  StepQuest
//
//  Created by Max Hakin on 18/12/2023.
//

import Foundation
import SpriteKit

class MissileTower: Tower {
    enum TowerLevel {
        case missile1
        case missile2
        case missile3

        var stats: (range: CGFloat, attackSpeed: TimeInterval, damage: Int, baseImage: String, topImage: String, projectileType: String, towerType: String) {
            switch self {
                case .missile1:
                    return (400, 10, 30, "towerBase1", "turretMissile1", "bomb1", "missile1")
                case .missile2:
                    return (500, 8, 50, "towerBase2", "turretMissile2", "bomb1", "missile2")
                case .missile3:
                    return (600, 5, 90, "towerBase3", "turretMissile3", "bomb2", "missile3")
            }
        }
    }
    var level: TowerLevel
    
    init(levelString: String, enemyHandler: EnemyHandler) {
        switch levelString {
            case "missile1":
                level = .missile1
            case "missile2":
                level = .missile2
            case "missile3":
                level = .missile3
            default:
                level = .missile1
        }
        
        let stats = level.stats
        super.init(enemyHandler: enemyHandler)
        
        range = stats.range
        attackSpeed = stats.attackSpeed
        damage = stats.damage
        baseImage = stats.baseImage
        topImage = stats.topImage
        projectileType = stats.projectileType
        towerType = stats.towerType
        
        makeTower()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }  
}
