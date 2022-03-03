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
    
    static var baseUrl = "https://pokeapi.co/api/v2/"
    
    // Endpoints
    var employeeListUrl = NetworkManager.baseUrl + "pokemon/"
    var employeeDetailUrl = NetworkManager.baseUrl + "detail/" // This is an example
    
    func getEmployeeList(completion: @escaping (Response?) -> Void) {
        guard let url = URL(string: employeeListUrl) else {
            completion(nil)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let networkTask = URLSession.shared.dataTask(with: urlRequest) {
            data, response, error in
            
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
    func getEmployeeWithDeatail(detailURL: String, completion: @escaping (Employee?) -> Void) {
        guard let url = URL(string: detailURL) else{
            completion(nil)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let networkTask = URLSession.shared.dataTask(with: urlRequest) {
            data, response, error in
            
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
                let employee = try decoder.decode(Employee.self, from: data)
                completion(employee)
            } catch {
                completion(nil)
            }
        }
        
        networkTask.resume()
    
    }
    func getPokemonImeg(<#parameters#>) -> <#return type#> {
        <#function body#>
    }

}
