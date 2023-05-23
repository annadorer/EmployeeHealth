//
//  HomeViewController.swift
//  EmployeeHealth
//
//  Created by Anna on 13.04.2023.
//

import UIKit
import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class HomeViewController: UIViewController {
    var employeeData = [EmployeeData]()
    func getData() {
        let db = Firestore.firestore()
        db.collection("Ответы сотрудников").getDocuments() { (querySnapshot, error) in
                for document in querySnapshot!.documents {
                    //print("\(document.documentID)=>\(document.data())")
                    let _data = try? document.data(as: EmployeeData.self)
                    self.employeeData.append(self.parcingData(data: document.data()))
                }
                print(self.employeeData)
        }
    }
    
    func parcingData(data: [String:Any]) -> (EmployeeData) {
        let decoder = JSONDecoder()
        let dict = data
        if let data = try?  JSONSerialization.data(withJSONObject: dict, options: []) {
            do {
                let _employeeData = try decoder.decode(EmployeeData.self, from: data)
            } catch {
                print(error)
            }
        }
        return try! decoder.decode(EmployeeData.self, from: JSONSerialization.data(withJSONObject: data))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
}
