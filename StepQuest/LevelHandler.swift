//
//  LevelHandler.swift
//  StepQuest
//
//  Created by Max Hakin on 07/12/2023.
//

import Foundation

class LevelHandler {
    
    struct EnemySpawnRate {
        let type: EnemyType
        var rate: Double
    }
    
    enum EnemyType {
        case alien, nerd, crab, wings, stomper
    }
    
    // Static enemy spawn rates
    var initialSpawnRates = [
        EnemySpawnRate(type: .alien, rate: 2),
        EnemySpawnRate(type: .nerd, rate: 1),
        EnemySpawnRate(type: .crab, rate: 0.4),
        EnemySpawnRate(type: .wings, rate: 0.3),
        EnemySpawnRate(type: .stomper, rate: 0.2)
    ]
    
    var enemyHandler: EnemyHandler
    var level: Int = 1
    
    init(enemyHandler: EnemyHandler) {
        self.enemyHandler = enemyHandler
    }
    
    func scaleForLevel(level: Int) -> Double {
        let baseScale = 1.0
        let growthFactor = 0.2 // Controls how quickly the difficulty scales
        return baseScale + growthFactor * Double(level - 1)
    }
    
    func spawnRatesForLevel(level: Int) -> [EnemySpawnRate] {
        let scale = scaleForLevel(level: level)
        return initialSpawnRates.map { EnemySpawnRate(type: $0.type, rate: $0.rate * scale) }
    }
    
    func generateSpawnSequence(forLevel level: Int) -> [EnemyType] {
        let rates = spawnRatesForLevel(level: level)
        var sequence: [EnemyType] = []
        
        // Calculate total number of enemies to spawn
        let totalEnemies = rates.reduce(0) { $0 + Int(round($1.rate)) }
        
        var remainingCounts = rates.map { (type: $0.type, count: Int(round($0.rate))) }
        
        for _ in 0..<totalEnemies {
            remainingCounts.shuffle() // Randomize the order of enemies
            if let index = remainingCounts.firstIndex(where: { $0.count > 0 }) {
                sequence.append(remainingCounts[index].type)
                remainingCounts[index].count -= 1
            }
        }
        
        return sequence
    }
    
    func spawnEnemies() {
        let spawnInterval = 2.0 // Adjust as needed
        let spawnSequence = generateSpawnSequence(forLevel: level)
        
        for (index, enemyType) in spawnSequence.enumerated() {
            let delay = Double(index) * spawnInterval
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                switch enemyType {
                case .crab:
                    self.enemyHandler.makeCrab()
                case .alien:
                    self.enemyHandler.makeAlien()
                case .nerd:
                    self.enemyHandler.makeNerd()
                case .stomper:
                    self.enemyHandler.makeStomper()
                case .wings:
                    self.enemyHandler.makeWings()
                }
                
            }
        }
    }
    
    func loadLevel() {
        enemyHandler.removeAllEnemies()
        spawnEnemies()
        print(level)
    }
}
