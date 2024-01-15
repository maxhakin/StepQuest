//
//  HealthKitHandler.swift
//  StepQuest
//
//  Created by Max Hakin on 14/01/2024.
//

import Foundation
import HealthKit

class HealthKitHandler {
    
    enum HealthKitError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
        case authorizationDenied
        case unexpectedError
    }
    
    var timeLastUpdated: Date?
    
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
        }
    }
    
    func fetchStepsCount(from startDate: Date, to endDate: Date, completion: @escaping (Double?, Error?) -> Void) {
        guard let stepsCount = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            completion(nil, HealthKitError.dataTypeNotAvailable)
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepsCount, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, statistics, error in
            guard let statistics = statistics, error == nil else {
                completion(nil, error)
                return
            }

            let sum = statistics.sumQuantity()?.doubleValue(for: HKUnit.count())
            completion(sum, nil)
        }

        healthStore.execute(query)
    }
    
    func fetchInitialWeeksSteps() {
        let now = Date()
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: now)!

        fetchStepsCount(from: oneWeekAgo, to: now) { steps, error in
            guard let steps = steps, error == nil else {
                // Handle error
                return
            }

            // Send `steps` to your database
        }
    }
    
    func updateStepCurrency() {
        let now = Date()
        let lastFetchedDate = timeLastUpdated ?? now
        let startOfDay = Calendar.current.startOfDay(for: now)

        // If the user hasn't used the app since yesterday or earlier
        if lastFetchedDate < startOfDay {
            fetchStepsCount(from: lastFetchedDate, to: now) { [weak self] steps, error in
                guard let steps = steps, error == nil else {
                    // Handle error
                    return
                }

                // Update currency with `steps`
                // Send `steps` and other relevant data to your database

                // Update 'last fetched' date
                self?.setTimeLastUpdated(lastTime: now)
            }
        }
    }
    
    func setTimeLastUpdated(lastTime: Date) {
        timeLastUpdated = lastTime
    }
    
    func getTimeLastUpdated() -> Date {
        return timeLastUpdated!
    }
}

