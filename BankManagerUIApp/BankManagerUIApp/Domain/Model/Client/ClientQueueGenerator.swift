//
//  ClientQueueGenerator.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import Foundation

struct ClientQueueGenerator {
    func generate(_ clientAmount: Int) -> ClientQueue<Client> {
        var clientQueue = ClientQueue<Client>()

        for number in 1...clientAmount {
            guard let requestName = Request.allCases.randomElement() else {
                return ClientQueue<Client>()
            }

            clientQueue.enqueue(Client(request: requestName, waitingNumber: number))
        }

        return clientQueue
    }
}
