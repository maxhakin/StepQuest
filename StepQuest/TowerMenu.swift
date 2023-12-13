//
//  TowerMenu.swift
//  StepQuest
//
//  Created by Louis Kürbis on 13/12/2023.
//

import Foundation
import SpriteKit

class TowerMenu: SKNode {
    
    var bombTowerButton: TowerMenuButton?
    var turretTowerButton: TowerMenuButton?
    var upgradeButton: TowerMenuButton?
    var deleteButton: TowerMenuButton?
    
    init(menuType: String) {
            super.init()
            self.position = position
        switch menuType {
        case "initial":
            bombTowerButton = TowerMenuButton(buttonImage: <#T##String#>, buttonText: <#T##String#>)
            
        }
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func createInitialMenu(towerExists: Bool, canUpgrade: Bool) {
            // Create and position buttons based on the tower state
            // For example, add build, upgrade, and delete buttons
        }

        // Add methods to handle button actions
    
    
}
