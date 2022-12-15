//
//  BankManagerable.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/15.
//

import Foundation

protocol BankManagerable: AnyObject {
    func startTask(for client: Client)
    func finishTask(for client: Client)
    func terminateTask()
}
