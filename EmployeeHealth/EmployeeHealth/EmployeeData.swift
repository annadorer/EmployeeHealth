//
//  EmployeeData.swift
//  EmployeeHealth
//
//  Created by Anna on 13.04.2023.
//

import Foundation
import FirebaseFirestoreSwift

enum Answers: Int, Codable {
    case never = 0
    case very_rarely = 1
    case rarely = 2
    case sometimes = 3
    case often = 4
    case very_often = 5
    case everyday = 6
}

struct EmployeeData: Codable {
    let FIO: String
    let department: String
    let id: UUID
    let question1: Int
    let question2: Int
    let question3: Int
    let question4: Int
    let question5: Int
    let question6: Int
    let question7: Int
    let question8: Int
    let question9: Int
    let question10: Int
    let question11: Int
    let question12: Int
    let question13: Int
    let question14: Int
    let question15: Int
    let question16: Int
    let question17: Int
    let question18: Int
    let question19: Int
    let question20: Int
}

struct supervisorData: Codable {
    let FIO: String
    let companyName: String
    let departmentName: String
}
