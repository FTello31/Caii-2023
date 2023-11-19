//
//  ScheduleDataModel.swift
//  Caii-2023
//
//  Created by Fernando Tello on 23/10/23.
//

import Foundation


struct EventsData: Codable {
    let error: Bool?
    let message: String?
    let datos: [EventD]?
}

struct EventD: Codable {
    let titulo: String
    let subtitulo: String?
    let lugar: String
    let fecha_desde: String
    let hora_inicio: String
    let hora_final: String
    let id: Int
    let confirmado: String?
    let enlace: String?
    
    var day:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = dateFormatter.date(from: fecha_desde) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "yyyy-MM-dd"
            let formattedDate = outputDateFormatter.string(from: date)
            return formattedDate  // Esto imprimirá "2023-11-27"
        } else {
            return "2023-11-28"
        }
    }
    
    var categoria: Int {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

           if let date = dateFormatter.date(from: fecha_desde) {
               let calendar = Calendar.current
               let components = calendar.dateComponents([.day], from: date)

               if let day = components.day {
                   if day == 27 {
                       return 1
                   } else if day == 28 {
                       return 2
                   }
               }
           }
           
           return 2
       }
}
