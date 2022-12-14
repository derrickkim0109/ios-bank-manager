//
//  BankRecord.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import Foundation

struct BankRecord: Hashable {
    let id = UUID()
    let task: String
}

extension BankRecord {
    static let sample = [
        BankRecord(task: "1-예금"),
        BankRecord(task: "2-대출"),
        BankRecord(task: "3-대출"),
        BankRecord(task: "4-예금"),
        BankRecord(task: "5-예금"),
    ]
}
