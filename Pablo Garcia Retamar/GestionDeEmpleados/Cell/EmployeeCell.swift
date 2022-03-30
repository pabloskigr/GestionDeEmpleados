//
//  EmployeeCell.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    var employee: Employee? {
        didSet { renderUI() }
    }

    static let identifier = "EmployeeCellIdentifier"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func renderUI() {
        guard let employee = employee else { return }
    
        nameLabel.text = employee.name
        jobLabel.text = employee.job
        salaryLabel.text = "\(employee.salary)$"
    }
}
