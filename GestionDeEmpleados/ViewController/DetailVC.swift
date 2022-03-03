//
//  DetailVC.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import UIKit

protocol DetailViewControllerDelegate {
    func didAddToOrder(employee: Employee)
}

class DetailVC: UIViewController {

    var employee: Employee?
    var delegate: DetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
