//
//  Notifications.swift
//  NotificationCenter
//
//  Created by Simran Rout on 11/02/23.
//

import Foundation

// MARK: Notifications Center Protocol
public protocol NotificationsCenterProtocol {
    func addObserver(for: AnyObject, identifier: String, selector: Selector)
    func post(identifier: String, data: Any?)
    func removeObserver(for classObject: AnyObject, identifier: String)
}

public extension NotificationsCenterProtocol {
    func post(identifier: String) {
        post(identifier: identifier, data: nil)
    }
}

// MARK: - Notifications
public class Notifications: NotificationsCenterProtocol {
    private var observers: Array<NotificationData> = []
    public static let manager: NotificationsCenterProtocol = Notifications()

    public func addObserver(for classObject: AnyObject, identifier: String, selector: Selector) {
        let data: NotificationData = .init(identifier: identifier, class: (object: classObject, selector: selector))
        observers.add(notification: data)
    }

    public func post(identifier: String, data: Any?) {
        observers.post(data, for: identifier)
    }

    public func removeObserver(for classObject: AnyObject, identifier: String) {
        observers.remove(for: classObject, and: identifier)
    }
}

// MARK: - Notification Data
fileprivate struct NotificationData: Equatable {
    let identifier: String
    let `class`: (object: AnyObject, selector: Selector)
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.class.object === rhs.class.object && lhs.class.selector == rhs.class.selector
    }

    func post(_ data: Any?) {
        _ = `class`.object.perform(`class`.selector, with: data)
    }
    
    func equals(_ identifier: String, and classObject: AnyObject) -> Bool {
        self.identifier == identifier && self.class.object === classObject
    }
}

// MARK: - Notification Data Array Extension
extension Array where Element == NotificationData {
    fileprivate subscript(id identifier: String) -> [Element] {
        return self.filter({ $0.identifier == identifier })
    }

    fileprivate mutating func add(notification data: Element) {
        guard checkIfDoesntExist(item: data) else { return }
        self.append(data)
    }

    fileprivate mutating func remove(for classObject: AnyObject, and identifier: String) {
        self.removeAll(where: { $0.equals(identifier, and: classObject) })
    }

    fileprivate func post(_ data: Any?, for identifier: String) {
        self[id: identifier].forEach({ $0.post(data) })
    }
    
    private func checkIfDoesntExist(item: Element) -> Bool {
        return first(where: { $0 == item }) == nil
    }
}
