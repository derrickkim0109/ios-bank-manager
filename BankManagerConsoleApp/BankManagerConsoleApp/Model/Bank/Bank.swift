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
    
    private let bankManagersGroup = DispatchGroup()

    private func arrange(bankManagers number: Int, to queue: ClientQueue<Client>) {
        for _ in 1...number {
            DispatchQueue.global().async(group: bankManagersGroup) { [weak self] in
                self?.bankManager.processTask(from: queue)
            }
        }
    }

    private func reportSummary(elapsedTime: CFAbsoluteTime) {
        print(
            """
            업무가 마감되었습니다.
            오늘 업무를 처리한 고객은 총 \(bankManager.retrieveTotalVisitedClients())명이며,
            총 업무시간은 \(elapsedTime.roundDown())초입니다.
            """)
    }

    func open(clients: (deposit: ClientQueue<Client>, loan: ClientQueue<Client>)) {

        let startTime = CFAbsoluteTimeGetCurrent()

        DispatchQueue.global().sync {
            arrange(bankManagers: Request.deposit.managerNumber, to: clients.deposit)
            arrange(bankManagers: Request.loan.managerNumber, to: clients.loan)

            bankManagersGroup.wait()
        }

        let closeTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = closeTime - startTime
        reportSummary(elapsedTime: elapsedTime)
    }

    func close() {
        totalProcessingTime = 0.0
        bankManager.clearTotalVisitedClientsRecord()
    }
}
