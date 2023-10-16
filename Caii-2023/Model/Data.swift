//
//  Data.swift
//  Caii-2023
//
//  Created by Fernando Tello on 8/10/23.
//

import Foundation

protocol ListItem {
    var name: String { get }
    var id: Int { get }
    var description: String { get }
    // Otras propiedades comunes si es necesario
}

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

struct TourismPlaces: Codable,ListItem {
    let name: String
    let id: Int
    let description: String
}

struct Restaurants: Codable,ListItem {
    let id: Int
    let name: String
    let description: String
    let location: String
    let website: String
}



struct Schedule: Codable {
    let id: Int
    let name: String
    let description: String
    let descriptionShort: String
    let day: String
    let linkVideo: String
}




struct HomeButton: Codable {
    let id: Int
    let name: String
    let color: String
    let image: String
    let viewControllerName: String
}

