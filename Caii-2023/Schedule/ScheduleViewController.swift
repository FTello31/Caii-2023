//
//  ScheduleViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 15/10/23.
//

import UIKit

class ScheduleViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    var filters = ["DIA 1","DIA 2"]
    
    var schedules: [ScheduleData] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionViewFilter: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        // Do any additional setup after loading the view.
        configureCollectionView()
        configureTableView()
        
        loadSchedule()
        setFirstFilterSelected()
        
        if (defaults.bool(forKey: "firstTimeSchedule") == true) {
            showPopUp()
            defaults.setValue(false, forKey: "firstTimeSchedule")
        }
    }
    
    func loadSchedule(){
        schedules =  fetchData()
    }
    
    func configureCollectionView(){
        collectionViewFilter.dataSource = self
        collectionViewFilter.delegate = self
    }
    
    func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "ScheduleTableViewCell")
    }
    
    func setFirstFilterSelected(){
        let indexPath = self.collectionViewFilter.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0)
        collectionViewFilter.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        filterDay(category: filters[0])
    }
    
    
    func filterDay(category: String){
        loadSchedule()
        
        schedules = schedules.filter { schedulePro in
            return schedulePro.day == category
        }
        
        self.tableView.reloadData()
    }
    
    
    func fetchData() -> [ScheduleData] {
        let schedule1 = ScheduleData(id: 1, name: "iOS App Development Workshop", description: "A hands-on workshop covering iOS app development, including UI design, networking, and Core Data.", descriptionShort: "Learn iOS App Development", day: "DIA 1", linkVideo: "workshop-ios-link", eventTime: "10:00 AM")
        let schedule2 = ScheduleData(id: 2, name: "Effective Team Collaboration", description: "Explore effective team collaboration strategies for software development projects, including communication and task management.", descriptionShort: "Team Collaboration", day: "DIA 1", linkVideo: "team-collaboration-link", eventTime: "11:30 AM")
        let schedule3 = ScheduleData(id: 3, name: "Xcode 13 Features Overview", description: "Discover the latest features and improvements in Xcode 13, including SwiftUI enhancements and debugging tools.", descriptionShort: "Xcode 13 Features", day: "DIA 1", linkVideo: "xcode-13-link", eventTime: "1:00 PM")
        let schedule4 = ScheduleData(id: 4, name: "Restaurant Marketing Panel", description: "Join a panel discussion on successful restaurant marketing strategies, featuring industry experts and case studies.", descriptionShort: "Restaurant Marketing", day: "DIA 1", linkVideo: "restaurant-panel-link", eventTime: "2:30 PM")
        let schedule5 = ScheduleData(id: 5, name: "Career Growth Success Stories", description: "Hear inspiring stories of professionals who achieved substantial career growth and increased their incomes.", descriptionShort: "Career Success Stories", day: "DIA 1", linkVideo: "career-success-stories-link", eventTime: "4:00 PM")
        let schedule6 = ScheduleData(id: 6, name: "Mobile App Gesture Design", description: "Learn the principles and techniques of designing user-friendly mobile app gestures for improved user experiences.", descriptionShort: "Gesture Design", day: "DIA 2", linkVideo: "gesture-design-link", eventTime: "10:30 AM")
        let schedule7 = ScheduleData(id: 7, name: "Tech Industry Trends 2023", description: "Explore the current and upcoming trends in the tech industry, from artificial intelligence to cybersecurity.", descriptionShort: "Tech Trends", day: "DIA 2", linkVideo: "tech-trends-2023-link", eventTime: "12:00 PM")
        let schedule8 = ScheduleData(id: 8, name: "Wireless App Development", description: "Discover how to develop and test your mobile apps wirelessly, saving time and enhancing development workflows.", descriptionShort: "Wireless App Development", day: "DIA 2", linkVideo: "wireless-development-link", eventTime: "2:00 PM")
        let schedule9 = ScheduleData(id: 9, name: "Swift Language Updates", description: "Stay updated with the latest changes and updates in the Swift programming language, including Swift 5.6 features.", descriptionShort: "Swift Updates", day: "DIA 2", linkVideo: "swift-updates-link", eventTime: "3:30 PM")
        let schedule10 = ScheduleData(id: 10, name: "Emerging Technologies Showcase", description: "Get a firsthand look at emerging technologies and their applications across various industries.", descriptionShort: "Emerging Technologies", day: "DIA 2", linkVideo: "emerging-technologies-link", eventTime: "5:00 PM")
        
        return [schedule1, schedule2, schedule3, schedule4, schedule5, schedule6, schedule7, schedule8, schedule9, schedule10]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is ScheduleDetailViewController {
            let vc = segue.destination as? ScheduleDetailViewController
            let detailToSend = sender as? ScheduleData
            vc?.detail = detailToSend
        }
        
    }
    
    func showPopUp() {
        let vc : ReusablePopUpViewController = ReusablePopUpViewController()
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        vc.titleLabel.text = "¡Sandra!"
        vc.descriptionLabel.text = "Encuentra todos los detalles de tu programa seleccionado aquí."
        
        present(vc, animated: true)
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


extension ScheduleViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as? FilterViewCell
        //            else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(ofType: FilterViewCell.self, for: indexPath)
        cell.labelFilterName.text = filters[indexPath.item]
        if cell.isSelected {
            cell.labelFilterName.textColor = .white
            cell.viewFilter.backgroundColor = .black
        } else {
            cell.labelFilterName.textColor = .black
            cell.viewFilter.backgroundColor = .white
        }
        cell.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FilterViewCell
        cell.isSelected = true
        cell.labelFilterName.textColor = .white
        cell.viewFilter.backgroundColor = .black
        
        filterDay(category: cell.labelFilterName.text!)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FilterViewCell else { return }
        cell.isSelected = false
        cell.labelFilterName.textColor = .black
        cell.viewFilter.backgroundColor = .white
        
    }
    
}


extension ScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schedule = schedules[indexPath.row]
        //        print(schedule)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        cell.eventNameLabel.text = schedule.name
        cell.eventDescriptionLabel.text = schedule.descriptionShort
        cell.timeLabel.text = schedule.eventTime
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        print(schedules[indexPath.row])
        //        performSegue(withIdentifier: "scheduleDetailSegue", sender: schedules[indexPath.row])
        performSegue(withIdentifier: "scheduleDetailSegue", sender: schedules[indexPath.row])
        
    }
    
    
    
    
}
