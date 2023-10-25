//
//  NotificationsService.swift
//  Caii-2023
//
//  Created by Fernando Tello on 24/10/23.
//

import Foundation
import UserNotifications

class NotificationsService {
    func setUpNotification(uuid : String, dateComponents : DateComponents, content : UNMutableNotificationContent) {
        let notificationCenter = UNUserNotificationCenter.current()
        // Get current scheduled notifications
        //let scheduledNotifications: Void = notificationCenter.getPendingNotificationRequests(completionHandler: {notificationInQueue in
            // Check if it exists
            //print(notificationInQueue)
        //})
        // Remove previous
        //print("Removing old")
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [uuid])
        // Add new one
        //print("Adding new")
        content.sound = UNNotificationSound.default
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: uuid,
                    content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
            print("Error!")
           }
        }
        //print("Done adding.")
    }
    
    func cancelNotification(uuid : String) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [uuid])
    }
    
}


//func setNotifications2(_ schedule:EventD){
//    //        print(schedule)
//    
//    let content = UNMutableNotificationContent()
//    content.title = schedule.titulo
//    content.body = schedule.subtitulo
//    content.sound = UNNotificationSound.default
//    
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "HH:mm"
//    dateFormatter.timeZone =  TimeZone.current
//    
//    guard let horaInicio = dateFormatter.date(from: schedule.hora_inicio) else {
//        return // No se pudo convertir la hora de inicio
//    }
//    
//    // Configura un disparador de tiempo para la notificación
//    let calendar = Calendar.current
//    let fechaActual = Date()
//    let fechaNotificacion = calendar.date(bySettingHour: calendar.component(.hour, from: horaInicio),
//                                          minute: calendar.component(.minute, from: horaInicio),
//                                          second: 0,
//                                          of: fechaActual)
//    print("fechaNotificacion",schedule.titulo,fechaNotificacion!)
//    
//    if let fechaNotificacion = fechaNotificacion, fechaNotificacion > fechaActual {
//        let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: fechaNotificacion), repeats: false)
//        
//        let request = UNNotificationRequest(identifier: "\(schedule.id)", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [String(schedule.id)])
//        // Agregar la notificación a UNUserNotificationCenter
//        UNUserNotificationCenter.current().add(request) { (error) in
//            if let error = error {
//                print("Error al programar la notificación: \(error)")
//            } else {
//                print("Notificación programada para \(schedule.titulo) a las \(schedule.hora_inicio).")
//            }
//        }
//    }
//    
//}
