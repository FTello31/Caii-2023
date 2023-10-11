//
//  Data.swift
//  Caii-2023
//
//  Created by Fernando Tello on 8/10/23.
//

import Foundation

struct Data: Codable {
//    let name: String
    let presentation: Presentation
}

struct Presentation: Codable {
    let name: String
    let job: String
    let text: String
}

struct PonentesData: Codable {
    let name: String
    let id: Int
    let category: String
}

struct EmergencyPhones: Codable {
    let name: String
    let number: Int
    let category: String
}
