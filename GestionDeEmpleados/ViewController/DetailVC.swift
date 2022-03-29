//
//  DetailVC.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import UIKit

class DetailVC: UIViewController {
    
    var employee: Employee?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let employee = employee else {return}
        
        nameLabel.text = employee.name
        jobLabel.text = employee.job
        biographyLabel.text = employee.biography
        salaryLabel.text = String(employee.salary)
        
        }
    }
