//
//  NetworkManager.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    static var baseUrl = "https://gestorDeEmpleados.com/"
    
    // Endpoints
    var employeeList = NetworkManager.baseUrl + "employee/"
    var employeeDetail = NetworkManager.baseUrl + "detail/"
    
    func login(name: String, password: String, completion: @escaping (Result<Int, Error>) -> Void){
        
        let parameters = ["name":name, "password":password]
        let baseURl = "https://gestorDeEmpleados.com/"
        
        guard let url = URL(string: baseURl + name) else {
            completion(.failure(logInError.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else{
            return
        }
        
        request.httpBody = httpBody
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request){(data, response, error) in
            DispatchQueue.main.async {
                
                guard let unWrappedResponse = response as? HTTPURLResponse else{
                    
                    completion(.failure(logInError.badResponse))
                    return
                }
                
                print(unWrappedResponse.statusCode)
                
                switch unWrappedResponse.statusCode{
                    
                case 200 ..< 300:
                    
                    print("success")
                    
                default:
                    
                    print("failure")
                    
                }
                if let unwrappedError = error{
                    
                    completion(.failure(unwrappedError))

                }
                if let unwrappedData = data{
                    
                    print(unwrappedData)
                    
                    do {
                        completion(.success(unWrappedResponse.statusCode))
                    }catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
    
    func register(name : String, password : String, completion: @escaping (Result<Int, Error>) -> Void){
    
        let parameters = ["name":name, "password":password] as [String : Any]
        
        guard let url = URL(string: "https://gestorDeEmpleados.com/public/api/register") else {
            
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
    
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else{
            
            return
        }
        
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response{
                
                print(response)
            }
            
            if let data = data {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    print(json)
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
    func getEmployeeList(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
        guard let url = URL(string: employeeList) else {
            completion(nil)
            return
        }
        var urlRequest = URLRequest(url: url, timeoutInterval: 10)
        
        if let params = params {
            guard let paramsData = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                completion(nil)
                return
            }
            
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = paramsData
        }
        
        let headers = [
            "Content-Type": "application/json",
            "Accept":       "application/json"
        ]
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = headers
        
        let urlSession = URLSession(configuration: sessionConfiguration)
        
        let networkTask = urlSession.dataTask(with: urlRequest) {
            data, response, error in
            
            let httpResponse = response as! HTTPURLResponse
            
            print("HTTP Status code: \(httpResponse.statusCode)")
            
            guard error == nil else {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                completion(response)
            } catch {
                completion(nil)
            }
        }
        
        networkTask.resume()
        
    }
    enum logInError: Error{
        case badURL
        case badResponse
    }
}
