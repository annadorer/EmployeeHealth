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
    @DocumentID var id: String?
    let FIO: String
    let department: String
    let answers1: String
    let answers2: String
    let answers3: String
    let answers4: String
    let answers5: String
    let answers6: String
    let answers7: String
    let answers8: String
    let answers9: String
    let answers10: String
    let answers11: String
    let answers12: String
    let answers13: String
    let answers14: String
    let answers15: String
    let answers16: String
    let answers17: String
    let answers18: String
    let answers19: String
    let answers20: String
}
