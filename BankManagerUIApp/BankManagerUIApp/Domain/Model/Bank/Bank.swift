//
//  Bank.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import Foundation

final class Bank {
    private var bankManager = BankManager()
    private var totalProcessingTime: Double = 0.0

    private let depositBankManagerOperation = OperationQueue()
    private let loanBankManagerOperation = OperationQueue()
    private let completionOperation = OperationQueue()
    
    init() {
        depositBankManagerOperation.maxConcurrentOperationCount = 2
        loanBankManagerOperation.maxConcurrentOperationCount = 1
    }

    func fetchDelegate(_ delegate: BankManagerable) {
        bankManager.delegate = delegate
    }

    func open(clients: ClientQueue<Client>) {
        arrange(to: clients)
    }

    private func arrange(to queue: ClientQueue<Client>) {
        while let client = queue.dequeue() {
            let bankManager = client.request

            let task = BlockOperation { [weak self] in
                self?.bankManager.processTask(from: client)
            }

            switch bankManager {
            case .deposit:
                depositBankManagerOperation.addOperation(task)
            case .loan:
                loanBankManagerOperation.addOperation(task)
            }
        }

        completionOperation.addOperation { [weak self] in
            self?.loanBankManagerOperation.waitUntilAllOperationsAreFinished()
            self?.depositBankManagerOperation.waitUntilAllOperationsAreFinished()
        }

        completionOperation.addOperation { [weak self] in
            self?.bankManager.delegate?.terminateTask()
        }
    }
}
