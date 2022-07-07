//
//  BankService.swift
//  BankManagerConsoleApp
//
//  Created by Derrick kim on 2022/07/06.
//

struct ClientGenerator {
    private var clients = ClientQueue<Client>()
    
    mutating func generate() -> ClientQueue<Client>? {
        let clientAmount = Int.random(in: 10...30)
    
        for number in 1...clientAmount {
            guard let task = Request.allCases.randomElement() else {
                return nil
            }
            clients.enqueue(Client(request: task, waitingNumber: number))
        }
        return clients
    }
}
