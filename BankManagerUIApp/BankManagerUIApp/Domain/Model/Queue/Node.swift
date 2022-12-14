//
//  Node.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import Foundation

final class Node<T> {
    var data: T
    var nextNode: Node?

    init(_ data: T) {
        self.data = data
    }
}
