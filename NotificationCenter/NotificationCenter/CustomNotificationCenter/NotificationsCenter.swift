//
//  NotificationsCenter.swift
//  NotificationCenter
//
//  Created by Simran Rout on 11/02/23.
//

import Foundation

public protocol NotificationsCenterProtocol {
    func addObserver(for: AnyObject, identifier: String, handler: Selector)
    func post(identifier: String, data: Any?)
    func removeObserver(for classObject: AnyObject, identifier: String)
}

public extension NotificationsCenterProtocol {
    func post(identifier: String) {
        post(identifier: identifier, data: nil)
    }
}

class NotificationsCenter: NotificationsCenterProtocol {
    static let `default`: NotificationsCenterProtocol = NotificationsCenter()
    private var observers: Array<NotificationCenterData> = []

    func addObserver(for classObject: AnyObject, identifier: String, handler: Selector) {
        let data: NotificationCenterData = .init(identifier: identifier, class: (object: classObject, handler: handler))
        observers.add(notification: data)
    }

    func post(identifier: String, data: Any?) {
        observers.post(data, for: identifier)
    }

    func removeObserver(for classObject: AnyObject, identifier: String) {
        observers.remove(for: classObject, and: identifier)
    }
}

struct NotificationCenterData: Equatable {
    let identifier: String
    let `class`: (object: AnyObject, handler: Selector)
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.class.object === rhs.class.object && lhs.class.handler == rhs.class.handler
    }

    func post(_ data: Any?) {
        _ = `class`.object.perform(`class`.handler, with: data)
    }
}

extension Array where Element == NotificationCenterData {
    subscript(id identifier: String) -> [Element] {
        return self.filter({ $0.identifier == identifier })
    }

    mutating func add(notification data: Element) {
        guard checkIfDoesntExist(item: data) else { return }
        self.append(data)
    }

    mutating func remove(for classObject: AnyObject, and identifier: String) {
        self.removeAll(where: { $0.identifier == identifier && $0.class.object === classObject })
    }

    fileprivate func post(_ data: Any?, for identifier: String) {
        self[id: identifier].forEach({ $0.post(data) })
    }
    
    private func checkIfDoesntExist(item: Element) -> Bool {
        return first(where: { $0 == item }) == nil
    }
}
