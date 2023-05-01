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
    
    func getData() {
        let db = Firestore.firestore()
        db.collection("Ответы сотрудников").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("error")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID)=>\(document.data())")
                    let data = try? document.data(as: EmployeeData.self)
                    self.parcingData(data: document.data())
                }
            }
        }
    }
    
    func parcingData(data: [String:Any]) {
        let decoder = JSONDecoder()
            //Make a mutable copy of the NSDictionary
            var dict = data
            for (key, value) in dict {
            //We need to check if the value is a Date (timestamp) and parse it as a string, since you cant serialize a Date. This might be true for other types you have serverside.
            if let value = value as? Date {
              let formatter = DateFormatter()
                dict[key] = formatter.string(from: value)
               }
             }
        if let data = try?  JSONSerialization.data(withJSONObject: dict, options: []) {
            do {
                let student = try decoder.decode(EmployeeData.self, from: data)
                print(student.FIO)
            } catch {
                print(error)
            }
        }
    }
    
        //let encoded = try? JSONDecoder().decode(EmployeeData.self, from: Data(data.utf8))
        let f = 0
        
        
        //let str = Data(data.utf8)
        
//        if let json = try! JSONSerialization.jsonObject(with: str, options: []) as? [String:Any] {
//            let name = json["FIO"] as? String ?? ""
//            let department = json["department"] as? String ?? ""
//            let answer1 = json["question1"]
//            let answer2 = json["question2"]
//            let answer3 = json["question3"]
//            let answer4 = json["question4"]
//            let answer5 = json["question5"]
//            let answer6 = json["question6"]
//            let answer7 = json["question7"]
//            let answer8 = json["question8"]
//            let answer9 = json["question9"]
//            let answer10 = json["question10"]
//            let answer11 = json["question11"]
//            let answer12 = json["question12"]
//            let answer13 = json["question13"]
//            let answer14 = json["question14"]
//            let answer15 = json["question15"]
//            let answer16 = json["question16"]
//            let answer17 = json["question17"]
//            let answer18 = json["question18"]
//            let answer19 = json["question19"]
//            let answer20 = json["question20"]
//            let employeeData = EmployeeData(FIO: name, department: department, answers1: as! Answers, answers2: as! Answers, answers3: as! Answers, answers4: as! Answers, answers5: as! Answers, answers6: as! Answers, answers7: answer7, answers8: answer8, answers9: answer9, answers10: answer10, answers11: answer11, answers12: answer12, answers13: answer13, answers14: answer14, answers15: answer15, answers16: answer16 as! Answers, answers17: answer17, answers18: answer18 as! Answers, answers19: answer19, answers20: answer20)
//        }
    //}
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            getData()
        }
}
