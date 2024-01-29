//
//  GameStateHandler.swift
//  StepQuest
//
//  Created by Max Hakin on 14/01/2024.
//

import Foundation
import SpriteKit

struct GameState: Codable {
    var userID: Int
    var userName: String
    var level: Int
    var towerData: [TowerData]
    var timeLastUpdated: Date
    var dailyStepData: [DailyStepCount]
    var firstTimeAccessed: Date?
    var totalSteps: Int
    var spentSteps: Int
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
    var userID: Int = 1
    var userName: String = "username"
    
    
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
        let gameState = GameState(userID: userID, userName: userName, level: getLvlData(), towerData: getTowerData(), timeLastUpdated: Date(), dailyStepData: healthKitHandler.dailySteps, firstTimeAccessed: healthKitHandler.firstTimeAccessed, totalSteps: Int(healthKitHandler.totalSteps), spentSteps: Int(healthKitHandler.spentSteps))
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
            let stepData = gameState.dailyStepData
            let firstDate = gameState.firstTimeAccessed!
            let stepsTotal = gameState.totalSteps
            let spentTotal = gameState.spentSteps
            userID = gameState.userID
            userName = gameState.userName
            towerHandler.restoreTowers(towerData: towerData)
            levelHandler.setLvl(level: level)
            healthKitHandler.setData(lastTime: lastUpdate, stepData: stepData, firstTime: firstDate, stepTotal: stepsTotal, spentTotal: spentTotal)
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
