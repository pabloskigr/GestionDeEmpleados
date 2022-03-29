//
//  MockData.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 29/3/22.
//

import Foundation

class MockData {
    
    static let shared = MockData()

    private init() {
        employee = loadEmployee()
    }
   
    var employee: [Employee] = []
    
    
     func loadEmployee() -> [Employee] {
        let filename = "employee.json"
        var data: Data
        
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
            
        do {
                data = try Data(contentsOf: file)
        } catch {
                fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Employee].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Employee.self):\n\(error)")
        }
        
    }
}
