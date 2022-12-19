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
        let taskGroup = DispatchGroup()

        delegate?.startTask(for: client)
        taskGroup.enter()
        DispatchQueue.global().asyncAfter(deadline: .now() + client.request.processingTime) { [weak self] in
            self?.delegate?.finishTask(for: client)
            taskGroup.leave()
        }
        taskGroup.wait()
    }
}
