//
//  ProfileVC.swift
//  GestionDeEmpleados
//
//  Created by pabloGarcia on 3/3/22.
//

import UIKit

class ProfileVC: UIViewController {
    
    
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var ListButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()

        }
    @IBAction func registerButtonTapped ( sender: Any){
        if let navCon = storyboard?.instantiateViewController(identifier: "RegisterId") as? RegisterVC{
            
            
            navCon.modalPresentationStyle = .fullScreen
            navCon.modalTransitionStyle = .flipHorizontal
            
            present(navCon, animated: true, completion: nil)
        }
    }
    
}
