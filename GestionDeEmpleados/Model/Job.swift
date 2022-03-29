//
//  Job.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 29/3/22.
//

import Foundation

enum Job: Int {
    case user = 0, boss, HR
    
    func toString() -> String {
        switch self {
        case .user: return "Usuario"
        case .boss: return "Jefe"
        case .HR: return "RRHH"
        }
    }
}
