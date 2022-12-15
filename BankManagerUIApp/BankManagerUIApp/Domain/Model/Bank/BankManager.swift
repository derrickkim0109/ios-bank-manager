//
//  BankManager.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import Foundation

final class BankManager {
    weak var delegate: BankManagerable?

    func processTask(from client: Client) {
        delegate?.startTask(for: client)
        processRequest(from: client)
        delegate?.finishTask(for: client)
    }

    private func processRequest(from client: Client) {
        Thread.sleep(forTimeInterval: client.request.processingTime)
    }
}
