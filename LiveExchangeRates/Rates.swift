//
//  Rates.swift
//  LiveExchangeRates
//
//  Created by Eren Elçi on 5.10.2024.
//

import Foundation


struct Rates: Codable {
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates: [String: Double] // Döviz isimlerini anahtar ve değerleri değer olarak tutacak.
}
