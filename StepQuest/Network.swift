//
//  Network.swift
//  StepQuest
//
//  Created by Max Hakin on 26/01/2024.
//

import Foundation

protocol Downloadable: AnyObject {
    func didReceiveData(data: Any)
}

enum URLServices {
    // change to your PHP script in your own server.
    static let setUsageData: String = "http://localhost:8888/MyHolidays/setUsageData.php"
    static let setUserData: String = "http://localhost:8888/MyHolidays/setUserData.php"
    static let getUserData: String = "http://localhost:8888/MyHolidays/getUserData.php"
    static let updateUserData: String = "http://localhost:8888/MyHolidays/updateUserData.php"
    
}

struct UserData: Codable {
    var userID: Int
    var email: String
    var userName: String
    var highLevel: Int
    var totalSteps: Int
}

struct ServerResponse: Codable {
    var success: Bool
    var message: String?
}

class Network{
    func request(parameters: [String: Any], url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        return request
    }
    
    func response(request: URLRequest, completionBlock: @escaping (Data) -> Void) -> Void {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {   // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
            }
            guard (200 ... 299) ~= response.statusCode else { //check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            // data will be available for other models that implements the block
            completionBlock(data);
        }
        task.resume()
    }
    
    func handleResponse(data: Data, completion: @escaping (Result<[UserData], Error>) -> Void) {
        do {
            let users = try JSONDecoder().decode([UserData].self, from: data)
            completion(.success(users))
        } catch {
                completion(.failure(error))
        }
    }
        
    func handleServerResponse(data: Data, completion: @escaping (Result<ServerResponse, Error>) -> Void) {
        do {
            let response = try JSONDecoder().decode(ServerResponse.self, from: data)
            completion(.success(response))
        } catch {
            completion(.failure(error))
        }
    }
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
