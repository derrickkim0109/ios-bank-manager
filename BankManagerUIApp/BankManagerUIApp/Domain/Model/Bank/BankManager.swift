//
//  BankManager.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import Foundation

final class BankManager {
    private var totalVisitedClients: Int = 0

    func processTask(from client: Client) {
        self.startTask(for: client)
        self.processRequest(from: client)
        self.finishTask(for: client)
    }

    func retrieveTotalVisitedClients() -> Int {
        return totalVisitedClients
    }

    func clearTotalVisitedClientsRecord() {
        self.totalVisitedClients = 0
    }

    private func finishTask(for client: Client) {
        self.totalVisitedClients += 1
        print("\(client.waitingNumber)번 고객 \(client.request.koreanTitle)업무 완료")
    }

    private func processRequest(from client: Client) {
        Thread.sleep(forTimeInterval: client.request.processingTime)
    }

    private func startTask(for client: Client) {
        print("\(client.waitingNumber)번 고객 \(client.request.koreanTitle)업무 시작")
    }
}
