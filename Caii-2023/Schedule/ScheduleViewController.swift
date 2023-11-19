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
    
    var schedules: [EventD] = []
    var schedulesFromAPI: [EventD] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionViewFilter: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        // Do any additional setup after loading the view.
        configureCollectionView()
        configureTableView()
        
//        loadSchedule()
        setFirstFilterSelected()
        
        if (defaults.bool(forKey: UDefaultValues.firstTimeSchedule.rawValue) == true) {
            showPopUp()
            defaults.setValue(false, forKey: UDefaultValues.firstTimeSchedule.rawValue)
        }
    }
    
//    func loadSchedule(){
//        fetchData()
//    }
    
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
        filterDay(category: 1)
    }
    
    
    func filterDay(category: Int){
        schedules = schedulesFromAPI

        schedules = schedules.filter({ schedu in
            return schedu.categoria == category
        })
        
        self.tableView.reloadData()
    }
    
    
//    func fetchData() {
//        let apiService = APIService()
//        apiService.getSchedulePrograms(completion: {sch in
//            switch sch {
//            case .success(let schedules):
//                self.schedulesFromAPI = schedules
//                self.filterDay(category: 1)
//
//            case .failure(let error):
//                print(error)
//            }
//        })
//            
//            
////        let schedule1 = ScheduleData(id: 1, name: String(localized: "iOS App Development Workshop"), description: "A hands-on workshop covering iOS app development, including UI design, networking, and Core Data.", descriptionShort: "Learn iOS App Development", day: "DIA 1", linkVideo: "workshop-ios-link", eventTime: "10:00 AM")
//    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is ScheduleDetailViewController {
            let vc = segue.destination as? ScheduleDetailViewController
            let detailToSend = sender as? EventD
            vc?.detail = detailToSend
        }
        
    }
    
    func showPopUp() {
        let vc : ReusablePopUpViewController = ReusablePopUpViewController()
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        vc.titleLabel.text = defaults.string(forKey: UDefaultValues.firstName.rawValue)
        vc.descriptionLabel.text = String(localized: "Encuentra todos los detalles de tu programa seleccionado aquí.")
        
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
        
        filterDay(category: indexPath.row+1)
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
        cell.eventNameLabel.text = schedule.titulo
        cell.eventDescriptionLabel.text = schedule.subtitulo
        cell.timeLabel.text = "\(schedule.hora_inicio) - \(schedule.hora_final)"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        print(schedules[indexPath.row])
        print("*****",schedules)
        //        performSegue(withIdentifier: "scheduleDetailSegue", sender: schedules[indexPath.row])
        performSegue(withIdentifier: "scheduleDetailSegue", sender: schedules[indexPath.row])
        
    }
    
    
    
    
}
