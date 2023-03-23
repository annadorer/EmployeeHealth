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

final class AuthViewController: UIViewController {
    
    @IBOutlet private var email: UITextField!
    @IBOutlet private var password: UITextField!
    
    
    @IBAction func loginAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "authToHome", sender: self)
            }
            else {
                self.wrongAuthError()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func wrongAuthError() {
        let alert = UIAlertController(title: "Ошибка", message: "Неправильно введен логин или пароль!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
