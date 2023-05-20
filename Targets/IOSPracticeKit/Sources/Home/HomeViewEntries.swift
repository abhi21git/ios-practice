//
//  HomeViewEntity.swift
//  IOSPracticeUI
//
//  Created by Simran Rout on 14/05/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import Foundation

// MARK: HomeViewEntries
public enum HomeViewEntries: String, CaseIterable {
    case tableView = "Table View"
    case collectionView = "Collection View"
    case notificationCenter = "Notification Center"
    
    public var title: String {
        return rawValue
    }
    
    public var imageName: String {
        switch self {
        case .tableView:
            return "list.bullet"
        case .collectionView:
            return "square.grid.2x2"
        case .notificationCenter:
            return "bell.and.waveform"
        }
    }
}
