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

    class func taskForPutRequest<RequestType: Encodable, ResponseType: Decodable>(urlBase: String, uniqueKey: String, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        let completeUrlString : String = urlBase + "/" + uniqueKey
        
        if let unwrappedUrl = URL(string: completeUrlString) {

            var request = URLRequest(url: unwrappedUrl)
            request.httpMethod = "PUT"
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
    
    class func getStudentLocations(completion: @escaping (Bool, Error?, StudentsInformationResponse?) -> Void) {
        
        taskForGETRequest(url: Endpoints.studentlocations.url, responseType: StudentsInformationResponse.self) { response, error in
            if let response = response {
                completion(response.results.count > 0, nil, response)
            } else {
                completion(false, error, nil)
            }
        }
    }
    
    class func postStudentLocation(uniqueKey: String, firstName: String, lastName: String,
                                   mapString: String, mediaURL: String,
                                   latitude: Double, longitude: Double,
                                   completion: @escaping (Bool, Error?, String) -> Void) {

        let body = StudentInformationRecord(objectId: "", uniqueKey: uniqueKey, firstName: firstName, lastName: lastName, mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longitude)
        
        taskForPOSTRequest(url: Endpoints.studentlocations.url, responseType: ParsePostResponse.self, body: body){ response, error in
            if let resp = response {
                completion(true, nil, resp.objectId)
            } else {
                completion(false, error, "")
            }
        }
    }
    
    class func putStudentLocation(objectId: String, uniqueKey: String, firstName: String, lastName: String,
                                   mapString: String, mediaURL: String,
                                   latitude: Double, longitude: Double,
                                   completion: @escaping (Bool, Error?) -> Void) {
        
        let body = StudentInformationRecord(objectId: objectId, uniqueKey: uniqueKey, firstName: firstName, lastName: lastName, mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longitude)
        
        taskForPutRequest(urlBase: Endpoints.studentlocations.stringValue, uniqueKey: objectId, responseType: ParsePostResponse.self, body: body){ response, error in
            if let _ = response {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
}
