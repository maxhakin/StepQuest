//
//  HealthKitHandler.swift
//  StepQuest
//
//  Created by Max Hakin on 14/01/2024.
//

import Foundation
import HealthKit

// Create a struct to hold daily step count data
struct DailyStepCount: Codable {
    let date: Date
    var steps: Int
}

class HealthKitHandler {
    
    // Error codes
    enum HealthKitError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
        case authorizationDenied
        case unexpectedError
    }
    
    var firstTimeAccessed: Date?
    var timeLastUpdated: Date?
    var totalSteps: Int = 0
    var spentSteps: Int = 0
    var dailySteps: [DailyStepCount] = []
    
    let healthStore = HKHealthStore()

    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        // Check if HealthKit is available
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthKitError.notAvailableOnDevice)
            return
        }

        // Define the data types we want to read and write
        guard let stepsCount = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            completion(false, HealthKitError.dataTypeNotAvailable)
            return
        }

        // Request authorization
        healthStore.requestAuthorization(toShare: [], read: [stepsCount]) { success, error in
            completion(success, error)
            print("Authorisation Succesful")
            self.fetchInitialWeeksSteps()
        }
    }
    
    
    func getSteps(from lastDay: Date) {
        
        let stepsType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfLastDay = Calendar.current.startOfDay(for: lastDay)
        let predicate = HKQuery.predicateForSamples(withStart: startOfLastDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsCollectionQuery.init(quantityType: stepsType,
                                                     quantitySamplePredicate: predicate,
                                                     options: .cumulativeSum,
                                                     anchorDate: startOfLastDay,
                                                     intervalComponents: DateComponents(day: 1))
        
        query.initialResultsHandler = { query, results, error in
            guard let statsCollection = results else {
                print("Error: Data could not be collected.")
                return
            }
            print("HK Query worked")
            statsCollection.enumerateStatistics(from: startOfLastDay, to: now) { statistics, stop in
                // Get the date associated with this interval
                let intervalDate = statistics.startDate
                // Get the step count for this interval (day)
                if let quantity = statistics.sumQuantity() {
                    let stepValue = Int(quantity.doubleValue(for: HKUnit.count()))

                    // Check if an entry with the same date already exists in the array
                    if let existingIndex = self.dailySteps.firstIndex(where: { $0.date == intervalDate }) {
                        // Update the existing entry with the new step count
                        self.dailySteps[existingIndex].steps = stepValue
                    } else {
                        // If it doesn't exist, append the new entry
                        let stepCount = DailyStepCount(date: intervalDate, steps: stepValue)
                        self.dailySteps.append(stepCount)
                    }
                }
            }
            self.setTotalSpendableSteps()
            print(self.totalSteps)
        }
        
        healthStore.execute(query)
        print("query skipped?")
    }

    
    func fetchInitialWeeksSteps() {
        print("Initial week called")
        let now = Date()
        firstTimeAccessed = Calendar.current.startOfDay(for: now)
        let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: now) ?? now
        
        getSteps(from: weekAgo)
    }
    
    func fetchStepsSinceLastUpdate() {
        getSteps(from: timeLastUpdated ?? Date())
    }
    
    func setTotalSpendableSteps() {
        // Define the date threshold
        let thresholdDate = Calendar.current.startOfDay(for: firstTimeAccessed!)

        // Filter the array to select DailyStepCount instances with dates after the threshold date
        let filteredCounts = dailySteps.filter { $0.date >= thresholdDate }

        // Calculate the total steps for the selected instances
        totalSteps = filteredCounts.reduce(0) { $0 + $1.steps }
    }
    
    
    func setData(lastTime: Date, stepData: [DailyStepCount], firstTime: Date, stepTotal: Int, spentTotal: Int) {
        timeLastUpdated = lastTime
        dailySteps = stepData
        firstTimeAccessed = firstTime
        totalSteps = stepTotal
        spentSteps = spentTotal
    }
    
    func getTimeLastUpdated() -> Date {
        return timeLastUpdated!
    }
}

