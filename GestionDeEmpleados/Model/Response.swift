//
//  Response.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import Foundation

struct Response: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [Employee]
}
