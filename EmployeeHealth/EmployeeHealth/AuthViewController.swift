//
//  AuthViewController.swift
//  EmployeeHealth
//
//  Created by Anna on 21.03.2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
class AuthViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    
    @IBAction func loginAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "authToHome", sender: self)
            }
            else {
                let alertController = UIAlertController(title: "Ошибка", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
