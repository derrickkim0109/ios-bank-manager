//
//  ClientGenerator.swift
//  BankManagerConsoleApp
//
//  Created by Derrick kim on 2022/07/07.
//

struct ClientQueueGenerator {
    func generate() -> ClientQueue<Client> {
        let numberOfClients = Int.random(in: 10...30)
        
        var clientQueue = ClientQueue<Client>()
        var loanClientQueue = ClientQueue<Client>()
        
        for number in 1...numberOfClients {
            guard let requestName = Request.allCases.randomElement() else {
                return ClientQueue<Client>()
            }

            clientQueue.enqueue(Client(request: requestName, waitingNumber: number))
        }
        
        return clientQueue
    }
}
