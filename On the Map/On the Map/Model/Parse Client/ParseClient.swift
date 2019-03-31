//
//  ParseClient.swift
//  On the Map
//
//  Created by John Berndt on 2/12/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

import Foundation

class ParseClient
{
    static let restApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    static let restAppID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    
    enum Endpoints {
        static let base = "https://parse.udacity.com/parse/classes"
        
        case studentlocations
        
        var stringValue : String {
            switch self {
            case .studentlocations: return Endpoints.base + "/StudentLocation"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
        
    }
  
    class func handleStudentsLocationsResponse(success: Bool, error: Error?, response: StudentsLocationsResponse?) {
        if success {
            print("Happy handleStudentsLocationsResponse")
            
            if let thedata = response {
                print("\(thedata.results)")
            }
            
        } else {
            let message = error?.localizedDescription ?? ""
            print("\(message)");
            print("Sad handleStudentsLocationsResponse")
        }
    }
    
    class func handleDataResponse(success: Bool, error: Error?) {
        if success {
            print("Happy handleDataResponse")
        } else {
            let message = error?.localizedDescription ?? ""
            print("\(message)");
            print("Sad handleDataResponse")
        }
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(restAppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(restApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ParsePostResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        
        let queryItems = [URLQueryItem(name: "limit", value: "100")]

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems? = queryItems
        
        var finalURL:URL = url;
        
        if let urlWithQuery = components?.url {

            finalURL = urlWithQuery;
        }
        
        var request = URLRequest(url: finalURL)
        request.addValue(restAppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(restApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ParseResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        
        return task
    }
    
    class func getStudentLocations(completion: @escaping (Bool, Error?, StudentsLocationsResponse?) -> Void) {
        
        taskForGETRequest(url: Endpoints.studentlocations.url, responseType: StudentsLocationsResponse.self) { response, error in
            if let response = response {
                print("true getStudentLocations")
                completion(response.results.count > 0, nil, response)
            } else {
                print("false getStudentLocations")
                completion(false, error, nil)
            }
        }
    }
    
    class func postStudentLocation(completion: @escaping (Bool, Error?) -> Void) {
        
        let body = StudentLocationRecord(uniqueKey: "0987654321", firstName: "Martin", lastName: "Bishop", mapString: "San Francisco, CA", mediaURL: "yahoo.com", latitude: 37.7749, longitude: 122.4194)
        
        taskForPOSTRequest(url: Endpoints.studentlocations.url, responseType: ParsePostResponse.self, body: body){ response, error in
            if let response = response {
                print("post true")
                completion(true, nil)
            } else {
                print("post false")
                completion(false, error)
            }
        }
    }
}
