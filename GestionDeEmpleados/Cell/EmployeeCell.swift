//
//  EmployeeCell.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import UIKit

class EmployeeCell: UITableViewCell {

    static let identifier = "EmployeeCellIdentifier"
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var employeeName: Employee? {
        didSet { renderUI() }
    }
    
    private func renderUI() {
        guard let employeeName = employeeName else {
            return
        }
        nameLabel.text = employeeName.name.capitalized
    }
}
