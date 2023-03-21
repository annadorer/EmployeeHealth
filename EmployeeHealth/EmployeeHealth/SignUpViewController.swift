//
//  SignUpViewController.swift
//  EmployeeHealth
//
//  Created by Anna on 21.03.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var companyName: UITextField!
    @IBOutlet var department: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var passwordConfirm: UITextField!
    
    
    @IBAction func signUpAction(_ sender: Any) {
        if password.text != passwordConfirm.text {
            _ = UIAlertController(title: "Пароли не совпадают", message: "Пожалуйста, введите пароль верно", preferredStyle: .alert)
            _ = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
