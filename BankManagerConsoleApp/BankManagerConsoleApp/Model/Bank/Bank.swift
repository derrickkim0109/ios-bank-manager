//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by minsson, Derrick kim on 2022/07/01.
//

import Foundation

final class Bank {
    private var bankManager = BankManager()
    private var totalProcessingTime: Double = 0.0

    private let depositBankManagerOperation = OperationQueue()
    private let loanBankManagerOperation = OperationQueue()

    init() {
        depositBankManagerOperation.maxConcurrentOperationCount = 2
        loanBankManagerOperation.maxConcurrentOperationCount = 1
    }

    func open(clients: ClientQueue<Client>) {
        let startTime = CFAbsoluteTimeGetCurrent()

        arrange(to: clients)

        let closeTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = closeTime - startTime
        reportSummary(elapsedTime: elapsedTime)
    }

    func close() {
        totalProcessingTime = 0.0
        bankManager.clearTotalVisitedClientsRecord()
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

        loanBankManagerOperation.waitUntilAllOperationsAreFinished()
        depositBankManagerOperation.waitUntilAllOperationsAreFinished()
    }

    private func reportSummary(elapsedTime: CFAbsoluteTime) {
        print(
            """
            업무가 마감되었습니다.
            오늘 업무를 처리한 고객은 총 \(bankManager.retrieveTotalVisitedClients())명이며,
            총 업무시간은 \(elapsedTime.roundDown())초입니다.
            """)
    }
}
