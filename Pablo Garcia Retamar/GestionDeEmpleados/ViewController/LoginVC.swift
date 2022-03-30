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
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var recoverButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func recoverButtonTapped ( sender: Any){
        
        if let navCon = storyboard?.instantiateViewController(identifier: "RecoverPasswordId") as? RecoverPasswordVC{
            
            navCon.modalPresentationStyle = .fullScreen
            navCon.modalTransitionStyle = .flipHorizontal
            present(navCon, animated: true, completion: nil)
        }
    }
    
    @IBAction func enterButtonTapped ( sender: Any){
        guard let name = emailTextField.text, !name.isEmpty else {
            let alertController = UIAlertController(title: "Rellene el campo de nombre", message: "",  preferredStyle: .actionSheet)
            self.present(alertController, animated: true, completion: nil)
            alertController.dismiss(animated: true, completion: nil)
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            let alertController = UIAlertController(title: "Rellene el campo de contraseña", message: "",  preferredStyle: .actionSheet)
            self.present(alertController, animated: true, completion: nil)
            alertController.dismiss(animated: true, completion: nil)
            return
        }
        

        if name.isEmpty == false && password.isEmpty == false{
            print("se supone que funciona")
            NetworkManager.shared.login(name: name, password: password) {
            result in
        }
            self.openProfileVC()
        }
    }
    
    private func openProfileVC() {
        if let navCo = storyboard?.instantiateViewController(identifier: "ProfileID") as? ProfileVC{
            
            navCo.modalPresentationStyle = .fullScreen
            navCo.modalTransitionStyle = .partialCurl
            
            present(navCo, animated: true, completion: nil)
        }
    }
}




        
