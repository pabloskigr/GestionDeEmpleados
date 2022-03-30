//
//  HomeVC.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var response: Response?
    var employee: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailID" {
            let employee = sender as! Employee
            let detailVC = segue.destination as! DetailVC
            detailVC.employee = employee
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MockData.shared.employee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCellIdentifier", for: indexPath) as? EmployeeCell {
            cell.employee = MockData.shared.employee[indexPath.row]
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print("Se pulso \(MockData.shared.employee[indexPath.row].name)")
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        performSegue(withIdentifier: "detailID", sender: MockData.shared.employee[indexPath.row])
    }
}
