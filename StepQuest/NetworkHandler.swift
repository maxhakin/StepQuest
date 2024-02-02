//
//  NetworkHandler.swift
//  StepQuest
//
//  Created by Max Hakin on 01/02/2024.
//

import Foundation

struct LeaderboardEntry: Codable {
    let userName: String
    let highLevel: Int
    let totalSteps: Int
}

class NetworkHandler {
    var network: Network
    var gameStateHandler: GameStateHandler
    
    
    init(network: Network, gameStateHandler: GameStateHandler) {
        self.network = network
        self.gameStateHandler = gameStateHandler
    }
    
    //Fetch user data from remote database through network API
    func setUsageData(userID: Int, highLevel: Int, totalSteps: Int) {
        let parameters = ["userID": userID, "level": highLevel, "steps": totalSteps] as [String: Any]
        print(parameters)
        let request = network.request(parameters: parameters, url: URLServices.setUsageData)
        
        network.response(request: request) { data in
            self.network.handleServerResponse(data: data) { result in
                switch result {
                case .success(let serverResponse):
                    // Handle successful response
                    print(serverResponse.message ?? "Success")
                case .failure(let error):
                    // Handle error
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //Set userData in remote database though network API
    func setUserData(username: String, highLevel: Int, totalSteps: Int) {
        let parameters = ["userName": username, "highLevel": highLevel, "totalSteps": totalSteps] as [String: Any]
        print(parameters)
        let request = network.request(parameters: parameters, url: URLServices.setUserData)
        
        network.response(request: request) { data in
            self.network.handleServerResponse(data: data) { result in
                switch result {
                case .success(let serverResponse):
                    if serverResponse.success {
                        // Data successfully saved
                        print(serverResponse.message ?? "Success")
                        if let userID = serverResponse.userID {
                            // Set userID to userID returned from the server
                            self.gameStateHandler.userID = userID
                            print("User ID: \(userID)")
                        }
                    } else {
                        // Server returned an error
                        print(serverResponse.message ?? "Error")
                    }
                case .failure(let error):
                    // Handle the error
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Update highlevel and totalSteps fow row in userID remote database where userID = userID
    func updateUserData(id: Int, level: Int, totalSteps: Int) {
        let parameters = ["userID": id, "highLevel": level, "totalSteps": totalSteps] as [String: Any]
        let request = network.request(parameters: parameters, url: URLServices.updateUserData) // Use your actual URL here
        
        network.response(request: request) { data in
            self.network.handleServerResponse(data: data) { result in
                switch result {
                case .success(let serverResponse):
                    // Handle successful response
                    print(serverResponse.message ?? "Success")
                case .failure(let error):
                    // Handle error
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Insert new row of usage data into remote database
    func insertDailyStats(userID: Int, dailySteps: [DailyStepCount]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let formattedSteps = dailySteps.map { stat -> [String: Any] in
            let dateString = dateFormatter.string(from: stat.date)
            return ["date": dateString, "steps": stat.steps]
        }

        // Prepare parameters for the network request, directly using the array of dictionaries
        let parameters = ["userID": userID, "dailySteps": formattedSteps] as [String : Any]

        // Call the sendJSONRequest method of the Network class
        network.JSONRequest(url: URLServices.updateDailyStats, jsonBody: parameters) { result in
            switch result {
                case .success(let serverResponse):
                    print("Server response: \(serverResponse.message ?? "")")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchLeaderboardData(completion: @escaping (Result<[LeaderboardEntry], Error>) -> Void) {
        guard let url = URL(string: URLServices.getLeaderBoard) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -2, userInfo: nil)))
                return
            }
            
            do {
                let leaderboardEntries = try JSONDecoder().decode([LeaderboardEntry].self, from: data)
                completion(.success(leaderboardEntries))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
