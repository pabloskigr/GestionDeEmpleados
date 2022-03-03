//
//  LoginVC.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    if let recoverPassVC = storyboard?.instantiateViewController(identifier: "RecoverPassVC") as? RecoverPassVC {
    recoverPassVC.modalPresentationStyle = .fullScreen
    recoverPassVC.modalTransitionStyle = .crossDissolve
    self.present(recoverPassVC, animated: true, completion: nil)
    }
        
        @IBAction func enterButton(_ sender: Any) {
                params = [
                    "email" : email_login.text ?? "",
                    "password"  : password_login.text ?? ""
                ]
                
                if !email_login.text!.isEmpty &&  !password_login.text!.isEmpty {
                    NetworkManager.shared.login(params: params){
                        response, error in DispatchQueue.main.async {
                            self.response = response
                            if response?.status == 1 && response?.msg == "Login correcto" {
                                
                                Session.shared.api_token = response?.api_token
                                let defaults = UserDefaults.standard
                                defaults.set(Session.shared.api_token, forKey: "api_token")
                                
                                let mainTabBarController = self.storyboard!.instantiateViewController(identifier: "MainTabBarController")
                                mainTabBarController.modalPresentationStyle = .fullScreen
                                self.present(mainTabBarController, animated: true, completion: nil)
                            
                            } else if error == .badData {
                                let alert = UIAlertController(title: "Error", message: "\(response?.msg ?? "Ha habido un error")", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                
                            } else if error == .errorConnection {
                                let alert = UIAlertController(title: "Error", message: "\(response?.msg ?? "Servidor no responde")", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                
                            } else {
                                let alert = UIAlertController(title: "Error", message: "\(response?.msg ?? "Crendenciales no correctas")", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                } else {
                    let alert = UIAlertController(title: "Error", message: "Campos vacios", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        
}
