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
        let notificationData: NotificationCenterData = .init(identifier: identifier, class: (name: classObject, handler: handler))
        observers.add(for: notificationData)
    }

    func post(identifier: String, data: Any?) {
        observers[id: identifier].forEach({ _ = $0.class.name.perform($0.class.handler, with: data) })
    }

    func removeObserver(for classObject: AnyObject, identifier: String) {
        observers.removeAll(where: {$0.identifier == identifier && $0.class.name === classObject})
    }
}

struct NotificationCenterData: Equatable {
    let identifier: String
    let `class`: (name: AnyObject, handler: Selector)
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.class.name === rhs.class.name && lhs.class.handler == rhs.class.handler
    }
}

extension Array where Element == NotificationCenterData {
    subscript(id identifier: String) -> [Element] {
        return self.filter({$0.identifier == identifier})
    }

    mutating func add(for data: Element) {
        guard checkIfDoesntExist(item: data) else { return }
        self.append(data)
    }
    
    private func checkIfDoesntExist(item: Element) -> Bool {
        return first(where: { $0 == item }) == nil
    }
}
