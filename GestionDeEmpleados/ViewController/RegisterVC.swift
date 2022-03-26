//
//  RegisterVC.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import UIKit

class RegisterVC: UIViewController {
    
    struct Data: Decodable{
            let status: Int
        }
        var status: Int?

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var jobPositionTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var biographyTextView: UITextView!
    @IBOutlet weak var enterButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func registrar(_ sender: Any) {
            
        let body = ["email": emailTextField.text ?? <#default value#>,
                        "contraseña": passwordTextField.text,
                        "nombre": nameTextField.text,
                        "puesto": jobPositionTextField.text,
                        "salario": salaryTextField.text,
                    "biografia": biographyTextView.textInputView] as [String : Any]
            
            let url = "http://192.168.64.2/empresa/public/api/empleados/registrar"
            
            AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: Data.self){response in
                self.status = response.value?.status
                print("response",response)
                print("status",response.value?.status)
                self.afterResponse()
            }
        }
        func afterResponse(){
            if (self.status == 1){
                //status ok
                let alert = UIAlertController(title: "Usuario registrado", message: "Haga login con sus credenciales", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                performSegue(withIdentifier: "registro_login", sender: nil)
            }else if (self.status == -1){
                //status al tener la contraseña mal
                print("status" ,self.status)
                let alert = UIAlertController(title: "Contraseña insegura", message: "Usa mayusculas, minusculas, numeros y minimo 6 caracteres", preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                self.present(alert, animated: true, completion: nil)
            }else{
                //manejo de error por fallo de conexion o exception de base de datos (email repetido)
                let alert = UIAlertController(title: "Error", message: "error de conexion", preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                self.present(alert, animated: true, completion: nil)
            }
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "registro_lista"{
                let listaVista = segue.destination as! LoginVC
            }
        }
    
}
