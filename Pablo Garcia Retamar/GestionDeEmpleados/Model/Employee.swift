//
//  Employee.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import Foundation

struct Employee: Codable {
    var id: Int = -1
    var name: String = "Error"
    var password: String = "a"
    var salary: Int = 0
    var job: String = "Usuario"
    var biography: String = "Error"
}
