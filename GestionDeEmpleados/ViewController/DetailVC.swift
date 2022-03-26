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
    var token:String? = ""
        var rol:String? = ""
        var id:Int? = nil
        var defaults = UserDefaults.standard
        
        
        var id2: Int?
        var name: String?
        var email: String?
        var job: String?
        var biography: String?
        var salary: Int?
        
        struct DataResponse: Decodable{
            let id: Int?
            let name: String?
            let email: String?
            let job: String?
            let biography: String?
            let salary: Int?
            
            enum CodignKeys: String, CodingKey {
                case id
                case nombre
                case email
                case puesto
                case biografia
                case salario
            }
        }

    var employee: Employee?
    var delegate: DetailViewControllerDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var jobLabel: UILabel!
    
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    override func viewDidLoad() {
            super.viewDidLoad()
            token = defaults.string(forKey: "token")!
            
            let url = "http://192.168.64.2/empresa/public/api/empleados/perfil"
            let body = ["token_val": token]
            
            AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: DataResponse.self){ [self] response in
                    //si se accede desde un list con otro id o es un empleado que acaba de loguear
                if response.value?.id != nil{
                    self.id2 = Int((response.value?.id)!)
                }else{
                    self.id2 = nil
                }
                
                self.name = response.value?.name
                self.email = response.value?.email
                self.job = response.value?.job
                self.biography = response.value?.biography
                self.salary = response.value?.salary
                            
                print("id", id,"id2",id2, "nombre",name, "email",email, "puesto",job, "biografia",biography, "salario", salary)
                nameLabel.text = name!
                jobLabel.text = job!
                salaryLabel.text = String(salary!)
                biographyLabel.text = biography!
            }
        }

        
    }
