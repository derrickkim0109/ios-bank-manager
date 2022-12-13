//
//  BankAppManager.swift
//  BankManagerConsoleApp
//
//  Created by minsson, Derrick kim on 2022/07/01.
//

struct BankAppManager {
    private var bank = Bank()
    private let clientGenerator = ClientQueueGenerator()
    
    private func setUpMenuList() {
        print(Const.bankOpen)
        print(Const.bankTerminator)
        print(Const.input, terminator: Const.empty)
    }
    
    mutating func run() {
        setUpMenuList()
        guard let selectedNumber = readLine(),
              let system = BankSystem(rawValue: selectedNumber) else {
            print(Const.wrongInput)
            run()
            return
        }
        
        switch system {
        case .on:
            let clients = clientGenerator.generate()
            bank.open(clients: clients)
            bank.close()
            run()
        case .off:
            break
        }
    }

    private enum Const {
        static let bankOpen = "1: 은행 개점"
        static let bankTerminator = "2: 종료"
        static let input = "입력 : "
        static let wrongInput = "\n입력이 잘못되었습니다. 다시 입력해주세요."
        static let empty = ""
    }
}
