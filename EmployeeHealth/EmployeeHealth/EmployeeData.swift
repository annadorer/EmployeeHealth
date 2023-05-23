//
//  EmployeeData.swift
//  EmployeeHealth
//
//  Created by Anna on 13.04.2023.
//

import Foundation
import FirebaseFirestoreSwift

enum Answers: Int, Codable {
    case never = 1
    case very_rarely = 2
    case rarely = 3
    case sometimes = 4
    case often = 5
    case very_often = 6
    case everyday = 7
}

struct EmployeeData: Codable {
    let FIO: String
    let department: String
    let id: UUID
    let question1: String
    let question2: String
    let question3: String
    let question4: String
    let question5: String
    let question6: String
    let question7: String
    let question8: String
    let question9: String
    let question10: String
    let question11: String
    let question12: String
    let question13: String
    let question14: String
    let question15: String
    let question16: String
    let question17: String
    let question18: String
    let question19: String
    let question20: String
}
