//
//  RegisterVC.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import UIKit

class RegisterVC: UIViewController {
    

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
        guard let name = emailTextField.text, !name.isEmpty else {
            let alertController = UIAlertController(title: "Rellene el campo del email", message: "",  preferredStyle: .actionSheet)
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

        if name.isEmpty == false && password.isEmpty == false {
            print("funciona el registro")
            NetworkManager.shared.register(name: name, password: password) {
            result in
        
            }
            self.openLoginVC()
        }
    }
   
    private func openLoginVC() {
        if let navCon = storyboard?.instantiateViewController(identifier: "LoginId") as? LoginVC{
            
            navCon.modalPresentationStyle = .fullScreen
            navCon.modalTransitionStyle = .partialCurl
            
            present(navCon, animated: true, completion: nil)
        }
    }
}
