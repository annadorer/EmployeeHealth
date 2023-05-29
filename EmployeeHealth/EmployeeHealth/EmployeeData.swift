//
//  EmployeeData.swift
//  EmployeeHealth
//
//  Created by Anna on 13.04.2023.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift
import CodableFirebase


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
    let question21: Int
    let question22: Int
    let date: Timestamp
}

struct SupervisorData: Codable {
    let FIO: String
    let companyName: String
    let departmentName: String
}

extension DocumentReference: DocumentReferenceType {}
extension GeoPoint: GeoPointType {}
extension FieldValue: FieldValueType {}
extension Timestamp: TimestampType {}
