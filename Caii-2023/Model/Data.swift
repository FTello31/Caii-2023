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
