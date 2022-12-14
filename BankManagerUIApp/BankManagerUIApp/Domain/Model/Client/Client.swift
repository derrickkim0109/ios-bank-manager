//
//  Client.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import Foundation

struct Client {
    private(set) var waitingNumber: Int
    private(set) var request: Request

    init(request: Request, waitingNumber: Int) {
        self.waitingNumber = waitingNumber
        self.request = request
    }
}
