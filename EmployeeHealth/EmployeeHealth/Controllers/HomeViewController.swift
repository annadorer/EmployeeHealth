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

    @IBOutlet private var tableView: UITableView?
    
    func getData() {
        let db = Firestore.firestore()
        db.collection("Ответы сотрудников").getDocuments() { (querySnapshot, error) in
                for document in querySnapshot!.documents {
                    self.employeeData.append(self.parcingData(data: document.data()))
                    self.tableView?.reloadData()

                }
                print(self.employeeData)
                self.tableView?.reloadData()
        }
    }
    
    func parcingData(data: [String:Any]) -> (EmployeeData) {
        let decoder = JSONDecoder()
        let dict = data
        if let data = try?  JSONSerialization.data(withJSONObject: dict, options: []) {
            do {
                let employeeData = try decoder.decode(EmployeeData.self, from: data)
            } catch {
                print(error)
            }
        }
        return try! decoder.decode(EmployeeData.self, from: JSONSerialization.data(withJSONObject: data))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        //self.tableView?.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIndentifier", for: indexPath)
        cell.textLabel?.text = employeeData[indexPath.row].FIO
        cell.detailTextLabel?.text = employeeData[indexPath.row].department
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = employeeData[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
