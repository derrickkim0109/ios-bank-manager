//
//  LinkedList.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import Foundation

final class LinkedList<Element> {
    private (set) var head: Node<Element>?
    private var tail: Node<Element>?

    func append(_ newNode: Node<Element>) {
        guard head != nil else {
            head = newNode
            tail = head
            return
        }

        tail?.nextNode = newNode
        tail = newNode
    }

    func isEmpty() -> Bool {
        return head == nil
    }

    func removeFirst() -> Element? {
        guard let removedNode = head else {
            return nil
        }

        head = removedNode.nextNode
        return removedNode.data
    }

    func removeAll() {
        head = nil
    }
}
