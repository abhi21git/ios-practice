//
//  Model.swift
//  Collectionview
//
//  Created by Abhishek Maurya on 11/05/23.
//

import Foundation

// MARK: Cities
public enum Cities: String, CaseIterable {
    case ankara = "Ankara"
    case antalya = "Antalya"
    case aydin = "Aydin"
    case bodrum = "Bodrum"
    case canakkale = "Canakkale"
    case cappadocia = "Cappadocia"
    case efes = "Efes"
    case eskisehir = "Eskisehir"
    case fethiye = "Fethiye"
    case istanbul = "Istanbul"
    case izmir = "Izmir"
    case mardin = "Mardin"
    case nemrut = "Nemrut"
    case pamukkale = "Pamukkale"
    case patara = "Patara"
    case rize = "Rize"
    case salda = "Salda"
    case sumela = "Sumela"
    
    public var name: String {
        return rawValue
    }
}
