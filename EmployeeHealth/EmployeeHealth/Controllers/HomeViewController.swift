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
import FirebaseAuth
import CodableFirebase



final class HomeViewController: UIViewController {
    
    var employeeData = [EmployeeData]()

    @IBOutlet private var tableView: UITableView?
    
    private func getData() {
        let db = Firestore.firestore()
        let query = db.collection("Информация о руководителях").whereField("email", isEqualTo: Auth.auth().currentUser?.email! as Any)
        
        query.getDocuments { (snapshot, error) in
            if error != nil {
                return
            } else {
                let currentUser = try! snapshot!.documents.first?.data(as: SupervisorData.self)
                let startDate = Date().startOfMonth()
                let endDate = Date().endOfMonth()
                let queryDocs = db.collection("Ответы сотрудников")
                    .whereField("department", isEqualTo: currentUser?.departmentName as Any)
                    .whereField("date", isGreaterThanOrEqualTo: startDate)
                    .whereField("date", isLessThanOrEqualTo: endDate)
                queryDocs.getDocuments() { [self] (querySnapshot, error) in
                        for document in querySnapshot!.documents {
                            self.employeeData.append(try! FirestoreDecoder().decode(EmployeeData.self, from: document.data()))
                        }
                        print(self.employeeData)
                        self.tableView?.reloadData()
                }
            }
        }
    }

    private func testResult(employeeData: EmployeeData) -> String {
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
        let anotherResult = "У данного сотрудника хорошее состояние!"
        return result == startStr ? anotherResult : result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
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

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
