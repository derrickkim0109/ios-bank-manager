//
//  ClientQueueGenerator.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import Foundation

final class ClientQueueGenerator {
    private var clientsBankRecord: [BankRecord] = []

    func generate(_ clientAmount: Int) -> ClientQueue<Client> {
        let clientQueue = ClientQueue<Client>()

        for number in clientAmount..<clientAmount + 10 {
            guard let requestName = Request.allCases.randomElement() else {
                return ClientQueue<Client>()
            }
            let client = Client(request: requestName, waitingNumber: number)
            clientsBankRecord.append(client.pickedUpTicket)

            clientQueue.enqueue(client)
        }

        return clientQueue
    }

    func setupClientList() -> [BankRecord] {
        return clientsBankRecord
    }
}
