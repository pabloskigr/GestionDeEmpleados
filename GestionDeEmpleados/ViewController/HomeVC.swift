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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "HOME"
        tabBarItem.title = "HOME"
        
        tableView.isHidden = true
        NetworkManager.shared.getEmployeeList {
            response in
            
            DispatchQueue.main.async {
                self.response = response
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmployeeToDetailSegue" {
            let employee = sender as! Employee
            let detailVC = segue.destination as! DetailVC
            detailVC.employee = employee
            detailVC.delegate = self as! DetailViewControllerDelegate
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath) as! EmployeeCell
        cell.employeeName = response?.results[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = storyboard.instantiateViewController(identifier: "BeerDetailVC") as? BeerDetailVC {
           // detailVC.beer = MockData.favoritos[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        
    }

}
