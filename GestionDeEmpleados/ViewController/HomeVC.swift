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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Esto es para llamar a la api
        //return response?.request.count ?? 0
        return MockData.shared.employee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCellIdentifier", for: indexPath) as? EmployeeCell {
            //Esto es para llamar a la api
            //cell.empleado = response?.request[indexPath.row]
            cell.employee = MockData.shared.employee[indexPath.row]
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Se pulso \(MockData.shared.employee[indexPath.row].name)")
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "DetalleEmpleado", sender: MockData.shared.employee[indexPath.row])
        //performSegue(withIdentifier: "DetalleEmpleado", sender: response?.request[indexPath.row])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetalleEmpleado" {
            let employee = sender as! Employee
            let detailVC = segue.destination as! DetailVC
            
            detailVC.employee = employee
        }
    }

}
