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
    
    @IBOutlet private var name: UITextField!
    @IBOutlet private var companyName: UITextField!
    @IBOutlet private var department: UITextField!
    @IBOutlet private var email: UITextField!
    @IBOutlet private var password: UITextField!
    @IBOutlet private var passwordConfirm: UITextField!
    
    
    @IBAction func signUpAction(_ sender: Any) {
        if password.text != passwordConfirm.text {
            passwordsConfirmError()
        } else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if error == nil {
                    let db = Firestore.firestore()
                    db.collection("Информация о руководителях").addDocument(data: self.generateUserData())
                    self.performSegue(withIdentifier: "signUpToHome", sender: self)
                } else {
                    self.textFieldsError()
                }
            }
        }
    }
    
    private func generateUserData() -> [String : Any] {
        var user: [String: Any] = ["FIO": name.text!,
                "companyName": companyName.text!,
                "departmentName": department.text!,
                "email": email.text!,
                "password": password.text!,
                "passwordConfirm": passwordConfirm.text!]

        return user
    }
    
    private func passwordsConfirmError() {
        let alert = UIAlertController(title: "Пароли не совпадают", message: "Пожалуйста, введите пароль верно", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func textFieldsError() {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
