//
//  GameStateHandler.swift
//  StepQuest
//
//  Created by Max Hakin on 14/01/2024.
//

import Foundation
import SpriteKit

struct GameState: Codable {
    var level: Int
    var towerData: [TowerData]
    var timeLastUpdated: Date
    //Add other relevant game state properties
}

struct TowerData: Codable {
    var type: String
    var xPos: Double
    var yPos: Double
}

class GameStateHandler {
    private var towerHandler: TowerHandler
    private var levelHandler: LevelHandler
    private var healthKitHandler: HealthKitHandler
    
    
    init(towerHandler: TowerHandler, lvlHandler: LevelHandler, healthKitHandler: HealthKitHandler) {
        self.towerHandler = towerHandler
        self.levelHandler = lvlHandler
        self.healthKitHandler = healthKitHandler
    }
    
    private func gameStateFilePath() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory.appendingPathComponent("GameState.json")
    }
    
    func saveGameState() {
        let gameState = GameState(level: getLvlData(), towerData: getTowerData(), timeLastUpdated: Date())
        do {
            let data = try JSONEncoder().encode(gameState)
            try data.write(to: gameStateFilePath(), options: .atomic)
            print("Game state saved successfully.")
        } catch {
            print("Error saving game state: \(error)")
        }
    }
    
    func loadGameState() {
        let filePath = gameStateFilePath()
        do {
            let data = try Data(contentsOf: filePath)
            let gameState = try JSONDecoder().decode(GameState.self, from: data)
            let towerData = gameState.towerData
            let level = gameState.level
            let lastUpdate = gameState.timeLastUpdated
            towerHandler.restoreTowers(towerData: towerData)
            levelHandler.setLvl(level: level)
            healthKitHandler.setTimeLastUpdated(lastTime: lastUpdate)
        } catch {
            print("Error loading game state: \(error)")
        }
    }
    
    func getTowerData() -> [TowerData] {
        return towerHandler.getTowerDataArray()
    }
    
    func getLvlData() -> Int {
        return levelHandler.getLvl()
    }
    
    func getTimeLastUpdated() -> Date {
        return healthKitHandler.getTimeLastUpdated()
    }
    
}
