//
//  ClientQueue.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import Foundation

final class ClientQueue<Element> {
    private let linkedList = LinkedList<Element>()

    var peek: Element? {
        return linkedList.head?.data
    }

    func enqueue(_ data: Element) {
        let newNode = Node(data)
        linkedList.append(newNode)
    }

    func dequeue() -> Element? {
        return linkedList.removeFirst()
    }

    func clear() {
        linkedList.removeAll()
    }
}
