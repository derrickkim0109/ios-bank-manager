//
//  Double+Extensions.swift
//  BankManagerConsoleApp
//
//  Created by minsson, Derrick kim on 2022/07/01.
//

extension Double {
    func roundDown() -> Double {
        guard let value = Double(String(format: "%.2f", self)) else {
            return 0.0
        }
        return value
    }
}
