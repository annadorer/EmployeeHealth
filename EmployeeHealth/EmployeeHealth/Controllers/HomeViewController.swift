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
        db.collection("Ответы сотрудников").getDocuments() { [self] (querySnapshot, error) in
                for document in querySnapshot!.documents {
                    self.employeeData.append(self.parcingData(data: document.data()))

                }
                print(self.employeeData)
                self.tableView?.reloadData()
        }
    }
    
    func parcingData(data: [String:Any]) -> (EmployeeData) {
        let decoder = JSONDecoder()
        let dict = data
        if let data = try? JSONSerialization.data(withJSONObject: dict, options: []) {
            do {
                _ = try decoder.decode(EmployeeData.self, from: data)
            } catch {
                print(error)
            }
        }
        return try! decoder.decode(EmployeeData.self, from: JSONSerialization.data(withJSONObject: data))
    }
    
    
    func testResult(employeeData: EmployeeData) -> String {
        let startStr = "У данного сотрудника: "
        var result = startStr
        if (employeeData.question1 + employeeData.question2 + employeeData.question3 + employeeData.question6 + employeeData.question8 + employeeData.question13 + employeeData.question14 + employeeData.question20) >= 36 {
            result = result + "эмоциональное истощение"
        }
        if (employeeData.question5 + employeeData.question10 + employeeData.question11 + employeeData.question15 + employeeData.question22) >= 20 {
            result = result + ".деперсонализация"
        }
        if (employeeData.question4 + employeeData.question7 + employeeData.question9 + employeeData.question12 + employeeData.question17 + employeeData.question18 + employeeData.question19 + employeeData.question21) >= 32 {
            result = result + ".обесценивание персональных достижений"
        }
        let anotherResult = "У данного сотрудника все отлично!"
        return result == startStr ? anotherResult : result
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
        cell.detailTextLabel?.text = self.testResult(employeeData: employeeData[indexPath.row]).split(separator: ".").joined(separator: ", ")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = employeeData[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
