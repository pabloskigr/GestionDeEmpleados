//
//  RecoverPasswordVC.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import UIKit

class RecoverPasswordVC: UIViewController {
   
    
    @IBOutlet weak var emailTexField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
       }
    @IBAction func sendButtonTaped(_ sender: Any) {
        
        if let navCon = storyboard?.instantiateViewController(identifier: "LoginId") as? LoginVC {
            
            navCon.modalPresentationStyle = .fullScreen
            navCon.modalTransitionStyle = .flipHorizontal
            
            present(navCon, animated: true, completion: nil)
        }
    }
}
