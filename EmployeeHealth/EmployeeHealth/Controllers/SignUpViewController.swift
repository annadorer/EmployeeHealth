//
//  SignUpViewController.swift
//  EmployeeHealth
//
//  Created by Anna on 21.03.2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var companyName: UITextField!
    @IBOutlet var department: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var passwordConfirm: UITextField!
    
    
    @IBAction func signUpAction(_ sender: Any) {
        if password.text != passwordConfirm.text {
            let alertController = UIAlertController(title: "Пароли не совпадают", message: "Пожалуйста, введите пароль верно", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "signUpToHome", sender: self)
                }
                else {
                    let alertController = UIAlertController(title: "Ошибка", message: "Заполните все поля!", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        "FIO": self.name.text!,
                        "companyName": self.companyName.text!,
                        "departmentName": self.department.text!,
                        "email": self.email.text!,
                        "password": self.password.text!,
                        "passwordConfirm": self.passwordConfirm.text!])
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
