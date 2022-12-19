//
//  Int+Extensions.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/15.
//

import Foundation

extension Int {
    func detailTime() -> (String, String, String) {
        let minute = String(format: "%02d", (self / (1000 * 60)) % 60)
        let second = String(format: "%02d", ((self / 1000) % 60))
        let milliSecond = String(format: "%03d", (self % 1000))
        return (minute, second, milliSecond)
    }
}
