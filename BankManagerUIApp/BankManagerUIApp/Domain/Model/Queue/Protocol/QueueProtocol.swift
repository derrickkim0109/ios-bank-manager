//
//  QueueProtocol.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import Foundation

protocol QueueProtocol {
    associatedtype Element

    var peek: Element? { get }
    mutating func enqueue(_ data: Element)
    mutating func dequeue() -> Element?
    func isEmpty() -> Bool
    func clear()
}
