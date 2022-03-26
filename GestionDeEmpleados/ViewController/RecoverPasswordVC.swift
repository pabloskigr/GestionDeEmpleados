//
//  RecoverPasswordVC.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import UIKit

class RecoverPasswordVC: UIViewController {
    struct Data: Decodable {
            var status: Int
        }
        var status:Int?

    @IBOutlet weak var emailTexField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    override func viewDidLoad() {
           super.viewDidLoad()
           
           
           // Do any additional setup after loading the view.
       }
    @IBAction func recuperar(_ sender: Any) {
            let url = "http://192.168.64.2/empresa/public/api/empleados/recuperarcontra"
            let body = ["email": emailTexField.text]
            
            AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: Data.self){response in
                print(response)
                self.status = response.value?.status
                print(self.status)
                self.afterResponse()
            }
        }
        func afterResponse(){
            print(status)
            if status == 1{
                let alert = UIAlertController(title: "Email enviado", message: "Revise su correo", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else if (status == 0){
                let alert = UIAlertController(title: "Eror", message: "Email no registrado", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Eror de conexion", message: "Compruebe su conexion", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
