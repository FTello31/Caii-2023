//
//  LoginDataModel.swift
//  Caii-2023
//
//  Created by Fernando Tello on 22/10/23.
//

import Foundation


struct UserData: Codable {
    let error: Bool?
    let datos: [UserInfo]?
    let message: String?
}

//struct DataInfo: Codable {
//    let user: UserInfo
//}

//struct UserInfo: Codable {
//    let name: String
//    let nombres: String
//    let apellidos: String
//}


struct UserInfo: Codable {
    let dni_doc: String
    let nombres: String
    let ap_paterno: String
    let ap_materno: String
    let organizacion: String
    let profesion: String
    let grupo: String
    let email: String
    let daccedio: String
    let modalidad_id: Int
}
