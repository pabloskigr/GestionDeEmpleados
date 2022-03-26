//
//  LoginVC.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import UIKit

class LoginVC: UIViewController {
    
    //datos que se recibiran desde la api al hacer la llamada (response)
    struct Data: Decodable {
           let token: String
           let job: String
           let id: Int
           let status: Int
       }
       var token:String?
       var job:String?
       var id:Int?
       var status:Int?
       var defaults = UserDefaults.standard

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
//    if let recoverPassVC = storyboard?.instantiateViewController(identifier: "RecoverPassVC") as? RecoverPassVC {
//    recoverPassVC.modalPresentationStyle = .fullScreen
//    recoverPassVC.modalTransitionStyle = .crossDissolve
//    self.present(recoverPassVC, animated: true, completion: nil)
//    }
        
        @IBAction func enterButton(_ sender: Any) {
            let url = "http://192.168.64.2/empresa/public/api/empleados/login"
                    let body = ["email": emailTextField.text, "contraseña": passwordTextField.text]
                    //body-> json que se le envia a la api, debe de coincidir
                    AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: Data.self){response in
                        print(response)
                        self.token = response.value?.token
                        if response.value?.token != nil {
                            self.defaults.set(self.token!, forKey: "token")
                        }
                        //se guarda en las variables la respuesta de la api
                        self.job = response.value?.job
                        self.id = response.value?.id
                        self.status = response.value?.status
                        self.afterResponse()
                    }
                }
                
                func afterResponse(){
                    if(status == 1){
                        print("llega1")
                        print("token",token!)
                        print("puesto",job!)
                        
                        print("Tu status es ",status!)
                        if job == "empleado"{ //si es empleado solo puede ver su propio perfil
                            performSegue(withIdentifier: "logueado_perfil", sender: nil)
                        }else{
                            performSegue(withIdentifier: "logueado_lista", sender: nil)
                        }
                    }else if (status == 0){
                        let alert = UIAlertController(title: "Error", message: "introduzca datos validos", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        
                            let alert = UIAlertController(title: "Error", message: "Compruebe su conexion", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                    }
                    
                }
                override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

                    if segue.identifier == "logueado_lista"{
                        let listaVista = segue.destination as! TableusersViewController
                        listaVista.token = token!
                        listaVista.puesto = puesto!
                        listaVista.id = id!
                        self.defaults.set(self.puesto!, forKey: "rol")
                        self.defaults.set(self.id!, forKey: "id")
                        
                    }
                    if segue.identifier == "logueado_perfil"{
                        let listaPerfil = segue.destination as! ProfileVC
                        listaPerfil.token = token!
                        listaPerfil.rol = puesto!
                        listaPerfil.id = id!
                        self.defaults.set(self.puesto!, forKey: "rol")
                        self.defaults.set(self.id!, forKey: "id")
                    }
                }
                
            }
//                params = [
//                    "email" : email_login.text ?? "",
//                    "password"  : password_login.text ?? ""
//                ]
//
//                if !email_login.text!.isEmpty &&  !password_login.text!.isEmpty {
//                    NetworkManager.shared.login(params: params){
//                        response, error in DispatchQueue.main.async {
//                            self.response = response
//                            if response?.status == 1 && response?.msg == "Login correcto" {
//
//                                Session.shared.api_token = response?.api_token
//                                let defaults = UserDefaults.standard
//                                defaults.set(Session.shared.api_token, forKey: "api_token")
//
//                                let mainTabBarController = self.storyboard!.instantiateViewController(identifier: "MainTabBarController")
//                                mainTabBarController.modalPresentationStyle = .fullScreen
//                                self.present(mainTabBarController, animated: true, completion: nil)
//
//                            } else if error == .badData {
//                                let alert = UIAlertController(title: "Error", message: "\(response?.msg ?? "Ha habido un error")", preferredStyle: UIAlertController.Style.alert)
//                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
//                                self.present(alert, animated: true, completion: nil)
//
//                            } else if error == .errorConnection {
//                                let alert = UIAlertController(title: "Error", message: "\(response?.msg ?? "Servidor no responde")", preferredStyle: UIAlertController.Style.alert)
//                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
//                                self.present(alert, animated: true, completion: nil)
//
//                            } else {
//                                let alert = UIAlertController(title: "Error", message: "\(response?.msg ?? "Crendenciales no correctas")", preferredStyle: UIAlertController.Style.alert)
//                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
//                                self.present(alert, animated: true, completion: nil)
//                            }
//                        }
//                    }
//                } else {
//                    let alert = UIAlertController(title: "Error", message: "Campos vacios", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//                }
//            }
//
//}
