//
//  HomeViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 7/10/23.
//

import UIKit
import UserNotifications

class HomeViewController: UIViewController {
    let defaults = UserDefaults.standard
    let customFont = UIFont(name: "Franie", size: 14)
    
    var homeButtons: [HomeButton] = []
    var schedulesFromAPI: [EventD] = []
    
    @IBOutlet weak var todayLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var mainEventNameLabel: UILabel!
        
    @IBOutlet weak var mainEventTimeLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    var eventoActualD: EventD? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        // Do any additional setup after loading the view.
        setupStyles()
        
        formatTodayDateLabel()
        
        setupCollectionView()
        
        setHomeButtons()
        
        if (defaults.bool(forKey: UDefaultValues.firstTimeHome.rawValue) == true) {
            showPopUp()
            defaults.setValue(false, forKey: UDefaultValues.firstTimeHome.rawValue)
        }
        
        checkForPermission()
//        fetchScheduleData()
        offlineData()
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        print("viewWillAppear")
        if(!schedulesFromAPI.isEmpty){
            setEventShown(schedulesFromAPI)
        }
    }
    
    
    func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                //                self.dispatchNotification()
                print("granted1")
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        //                        self.dispatchNotification()
                        print("granted2")
                        
                    }
                }
            default:
                return
            }
        }
        
    }
    
    
    func setupStyles(){
        whiteView.layer.cornerRadius = 15
        logoutBtn.layer.cornerRadius = 30
        logoutBtn.layer.masksToBounds = true
        
        mainEventTimeLabel.font = customFont
//        mainEventPlaceLabel.font = customFont
    }
    
    func formatTodayDateLabel(){
        let date = Date()
        
//        print("a",Bundle.main.preferredLocalizations)
//        print("a",Bundle.main.preferredLocalizations[0])
//        print("b",Locale.current)
        
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "dd MMMM"
        
        todayLabel.text = formatter.string(from: date)
        print(formatter.string(from: date))
        
        
    }
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func setHomeButtons() {
        let button1 = HomeButton(id: 1, name: String(localized: "Presentación"), color: "PrimaryCAII", image: "icons8-presentation-60", viewControllerName: "PresentationViewController")
        let button2 = HomeButton(id: 2, name: String(localized: "Mi Programa"), color: "GreyCAII", image: "icons8-schedule-60", viewControllerName: "ScheduleViewController")
        let button3 = HomeButton(id: 3, name: String(localized: "Sede"), color: "YellowCAII", image: "icons8-library-60", viewControllerName: "SedeMainViewController")
        let button4 = HomeButton(id: 4, name: String(localized: "Ponentes"), color: "LightblueCAII", image: "icons8-people-60", viewControllerName: "PonentesViewController")
        let button5 = HomeButton(id: 5, name: String(localized: "Turismo"), color: "BlueCAII", image: "icons8-tourism-60", viewControllerName: "TourismViewController")
        let button6 = HomeButton(id: 6, name: String(localized: "Contactos de emergencia"), color: "PrimaryCAII", image: "icons8-emergency-60", viewControllerName: "EmergencyPhonesViewController")
        let button7 = HomeButton(id: 7, name: String(localized: "CAII en vivo"), color: "BlueCAII", image: "icons8-live-video-on-60", viewControllerName: "CAIIViewController")

        
        if(defaults.string(forKey: "version")!.elementsEqual("1")){
            homeButtons = [button1, button2, button3, button4, button5, button6]
        }else if(defaults.string(forKey: "version")!.elementsEqual("2")){
            homeButtons = [button7, button1, button2, button4, button3, button6]
        }else if(defaults.string(forKey: "version")!.elementsEqual("3")){
            homeButtons = [button1, button2, button3, button4, button5, button6]
        }
    }
    
    
    
//    func fetchScheduleData() {
//        let apiService = APIService()
//        
//        apiService.getSchedulePrograms(completion: {sch in
//            switch sch {
//            case .success(let schedules):
//                print(schedules)
//                apiService.getGeneralPrograms(completion: {sch2 in
//                    switch sch2 {
//                    case .success(let schedulesGeneral):
//                        print(schedulesGeneral)
//                        
//                        self.schedulesFromAPI = schedules + schedulesGeneral  /*TODO*/
//    //                  self.schedulesFromAPI = self.offlineData()
//                        self.setEventShown(self.schedulesFromAPI)
//                        self.setNotificationsFromAPI(self.schedulesFromAPI)
//                        //            self.setNotifications(self.schedulesFromAPI)
//                        
//                    case .failure(let error):
//                        self.schedulesFromAPI = schedules /*TODO*/
//    //                  self.schedulesFromAPI = self.offlineData()
//                        self.setEventShown(self.schedulesFromAPI)
//                        self.setNotificationsFromAPI(self.schedulesFromAPI)
//                        print(error)
//                    }
//                })
//                
//            case .failure(let error):
//                print(error)
//            }
//        })
//        
//    }
    
    func offlineData() {
        let data = [
            [
                "titulo": "PANEL 1:",
                "subtitulo": "A casi una década de su revelación: ¿estamos ante el final del caso “Lava Jato” y sus redes en América Latina?",
                "lugar": "Sala De las Naciones 1 – 8vo piso",
                "fecha_desde": "2023-10-24 00:00:00",
                "hora_inicio": "11:12",
                "hora_final": "11:15",
                "id": 609,
                "confirmado": "S",
                "enlace": nil
            ],
            [
                "titulo": "FORO 1:",
                "subtitulo": "Control gubernamental y control político. El trabajo conjunto de las Entidades Fiscalizadoras Superiores y los Parlamentos",
                "lugar": "Sala Puruchuco – 4to piso",
                "fecha_desde": "2023-10-24 00:00:00",
                "hora_inicio": "11:20",
                "hora_final": "11:22",
                "id": 611,
                "confirmado": "S",
                "enlace": nil
            ],
            [
                "titulo": "PRESENTACIÓN DE INVESTIGACIÓN",
                "subtitulo": "De película de terror a las instituciones públicas de la región: El escándalo de los trabajadores y empresas fantasmas",
                "lugar": "Sala Huallamarca – 4to piso",
                "fecha_desde": "2023-10-25 00:00:00",
                "hora_inicio": "11:25",
                "hora_final": "11:30",
                "id": 614,
                "confirmado": "S",
                "enlace": nil
            ],
            [
                "titulo": "PANEL 4:",
                "subtitulo": "¿Se puede elegir al mejor postor? Avances y retos de las contrataciones públicas en el Perú",
                "lugar": "Sala de las Naciones 1 – 8vo piso",
                "fecha_desde": "2023-10-25 00:00:00",
                "hora_inicio": "11:33",
                "hora_final": "11:36",
                "id": 615,
                "confirmado": "S",
                "enlace": nil
            ],
            [
                "titulo": "EXPOSICIÓN DE CORTOMETRAJES POR LA INTEGRIDAD",
                "subtitulo": "Proyecto “Haz corto con la corrupción”",
                "lugar": "Sala De las Naciones 3 – 8vo piso",
                "fecha_desde": "2023-10-25 00:00:00",
                "hora_inicio": "11:40",
                "hora_final": "11:43",
                "id": 620,
                "confirmado": "S",
                "enlace": nil
            ],
            [
                "titulo": "EXPOSICIÓN DE CORTOMETRAJES POR LA INTEGRIDAD",
                "subtitulo": "“La colaboración transnacional para investigar casos de corrupción”",
                "lugar": "Sala de las Naciones 1 – 8vo piso",
                "fecha_desde": "2023-10-25 00:00:00",
                "hora_inicio": "11:45",
                "hora_final": "11:50",
                "id": 622,
                "confirmado": "S",
                "enlace": nil
            ]
        ]
        
        var eventDArray = [EventD]()
        
        for event in data {
            if let titulo = event["titulo"] as? String,
               let subtitulo = event["subtitulo"] as? String,
               let lugar = event["lugar"] as? String,
               let fecha_desde = event["fecha_desde"] as? String,
               let hora_inicio = event["hora_inicio"] as? String,
               let hora_final = event["hora_final"] as? String,
               let id = event["id"] as? Int,
               let confirmado = event["confirmado"] as? String {
                
                let enlace = event["enlace"] as? String
                
                let eventD = EventD(titulo: titulo, subtitulo: subtitulo, lugar: lugar, fecha_desde: fecha_desde, hora_inicio: hora_inicio, hora_final: hora_final, id: id, confirmado: confirmado, enlace: enlace)
                
                eventDArray.append(eventD)
            }
        }
        
        self.schedulesFromAPI = eventDArray
//        return eventDArray
        
    }
    
    
    func setEventShown(_ schedules: [EventD]){
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone.current
        let currentDateString = dateFormatter.string(from: currentDate)
        
        // Convierte la hora actual en formato "yyyy-MM-dd HH:mm" a Date
        if let currentDate = dateFormatter.date(from: currentDateString) {
            // Encuentra el evento actual
            var eventoActual: EventD?
            //            eventoActual = schedules[0]
            for evento in schedules {
                if let eventStartDate = dateFormatter.date(from: evento.fecha_desde.split(separator: " ").first!  + " " + evento.hora_inicio),
                   let eventEndDate = dateFormatter.date(from: evento.fecha_desde.split(separator: " ").first!  + " " + evento.hora_final) {
                    if currentDate >= eventStartDate && currentDate <= eventEndDate {
                        eventoActual = evento
                        break
                    }
                }
            }
            
            if eventoActual == nil {
                for evento in schedules {
                    if let eventStartDate = dateFormatter.date(from: evento.fecha_desde.split(separator: " ").first!  + " " + evento.hora_inicio){
                        if currentDate < eventStartDate {
                            eventoActual = evento
                            break
                        }
                        
                    }
                }
            }
            
            if eventoActual == nil {
                eventoActual = schedules.last
            }
            
//            
//            //last event
//            if (currentDate > dateFormatter.date(from: schedules.last!.fecha_desde.split(separator: " ").first!  + " " + schedules.last!.hora_final)!) {
//                eventoActual = schedules.last
//            }
//            
            
            if let eventoActual = eventoActual {
                showCurrentEvent(eventoActual)
                // Imprime otros detalles del evento según sea necesario
            } else {
                print("No hay eventos en curso en este momento.")
            }
        } else {
            print("Error al convertir la fecha actual.")
        }
        //        let currentTime = Date()
        //print("currentTimecurrentTime",currentTime)
        //
        //        let date = Date()
        //        let calendar = Calendar.current
        //        let date22 = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: date)
        //
        //        let month = calendar.component(.month, from: date)
        //        let day = calendar.component(.day, from: date)
        //        let hour = calendar.component(.hour, from: date)
        //        let minutes = calendar.component(.minute, from: date)
        //        print("date22",date22)
        //        print("calendar",calendar)
        //        print("month",month)
        //        print("day",day)
        //        print("hourhourhour",hour)
        //        print("minutesminutesminutes",minutes)
        
        //
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "HH:mm"
        //        dateFormatter.timeZone = TimeZone.current
        //        print("***********",schedules[0])
        //        print(dateFormatter.date(from: schedules[0].hora_inicio))
        //        print(dateFormatter.date(from: schedules[0].hora_final))
        
        
    }
    
    
    func showCurrentEvent(_ eventoActual:EventD){
//        print("El evento actual es:")
//        print("Título: \(eventoActual.titulo)")
//        print("Subtítulo: \(eventoActual.subtitulo)")
//        print("Lugar: \(eventoActual.lugar)")
        mainEventNameLabel.text = "\(eventoActual.titulo) \(eventoActual.subtitulo ?? " ")"
        mainEventTimeLabel.text = "\(eventoActual.hora_inicio) hrs"
//        mainEventPlaceLabel.text = "Lugar: \(eventoActual.lugar)"
        eventoActualD = eventoActual
    }
    
    
    func setNotificationsFromAPI(_ schedules:[EventD]){
        
        //setting notifications
        for schedule in schedules {
            setNotifications(schedule)
        }
        
        // SHOW scheduled notifications
        print(UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications) in
            print("Count: \(notifications.count)")
            for item in notifications {
                print(item.content)
            }
        })
        
    }
    
    func setNotifications(_ schedule:EventD){
        
        let content = UNMutableNotificationContent()
        content.title = schedule.titulo
        content.body = schedule.subtitulo ?? "-"
        content.sound = UNNotificationSound.default
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone =  TimeZone.current
        
        if let eventDate = dateFormatter.date(from: schedule.fecha_desde.split(separator: " ").first! + " " + schedule.hora_inicio) {
            print(eventDate)
            // Configura el disparador de la notificación
            let calendar = Calendar.current
            let triggerDate = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: eventDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            
            // Crea una solicitud de notificación
            let identifier = "\(schedule.id)"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [String(schedule.id)])
            
            // Programa la notificación
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Error al programar la notificación: \(error.localizedDescription)")
                } else {
                    print("Notificación programada para \(schedule.titulo)")
                }
            }
        }
        
    }
    
    func showPopUp() {
        let avc : ReusablePopUpViewController = ReusablePopUpViewController()
        avc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        avc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        avc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        avc.titleLabel.text = String(localized:"¡Hola, \(defaults.string(forKey: UDefaultValues.firstName.rawValue)!)!")
        avc.descriptionLabel.text = String(localized:"Bienvenido a la CAII 2023. Encuentra tu programa personalizado y toda la información sobre el evento aquí.")
        
        present(avc, animated: true)
    }
    
    @IBAction func onLogoutPressed(_ sender: UIButton) {
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        print(Array(defaults.dictionaryRepresentation().keys).count)
        
        // Pop to the root view controller (LoginViewController)
        //self.navigationController?.popToRootViewController(animated: true)
        
        goToLoginStoryboard()
    }
    
    
    
    
    func goToLoginStoryboard() -> Void {
        let storyboard = UIStoryboard(name: "Login", bundle: .main)
        
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension HomeViewController:
    UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //
    //            let columns = 3
    //            let width = Int(UIScreen.main.bounds.width)
    //            let side = width / columns
    //            let rem = width % columns
    //            let addOne = indexPath.row % columns < rem
    //            let ceilWidth = addOne ? side + 1 : side
    //            return CGSize(width: ceilWidth, height: side)
    //
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeButtons.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: HomeButtonCollectionViewCell.self, for: indexPath)
        
        cell.backgroundIcon.backgroundColor = UIColor(named: homeButtons[indexPath.item].color)
        cell.icon.image = UIImage(named: homeButtons[indexPath.item].image)
        cell.nameLabel.text = homeButtons[indexPath.item].name
        
        cell.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        let cell = collectionView.cellForItem(at: indexPath) as! HomeButtonCollectionViewCell
        //        cell.isSelected = true
        
        if(homeButtons[indexPath.item].viewControllerName.elementsEqual("CAIIViewController")) {
            
            if(eventoActualD?.enlace != ""){
                if let zoomURL = URL(string: (eventoActualD?.enlace)!) {
                    // redirect through safari
                    UIApplication.shared.open(zoomURL, options: [:], completionHandler: nil)
                }
            }
            
        } else if(homeButtons[indexPath.item].viewControllerName.elementsEqual("ScheduleViewController")){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: homeButtons[indexPath.item].viewControllerName) as! ScheduleViewController
            print(schedulesFromAPI)
            vc.schedules = schedulesFromAPI
            vc.schedulesFromAPI = schedulesFromAPI
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: homeButtons[indexPath.item].viewControllerName) as UIViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}
