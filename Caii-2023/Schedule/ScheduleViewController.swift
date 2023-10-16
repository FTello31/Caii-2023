//
//  ScheduleViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 15/10/23.
//

import UIKit

class ScheduleViewController: UIViewController {

    var filters = ["DIA 1","DIA 2"]

    var schedules: [Schedule] = []

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
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    func setFirstFilterSelected(){
        let indexPath = self.collectionViewFilter.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0)
        collectionViewFilter.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.left)
        filterDay(category: filters[0])
    }
    
    
    func filterDay(category: String){
        loadSchedule()
        
        schedules = schedules.filter { schedulePro in
            return schedulePro.day == category
        }
        
        self.tableView.reloadData()
    }
    
    
    func fetchData() -> [Schedule] {
        let schedule1 = Schedule(id: 1, name: "No Storyboards", description: "Long description of No Storyboards", descriptionShort: "Short description", day: "DIA 1", linkVideo: "video1-link")
        let schedule2 = Schedule(id: 2, name: "5 Soft Skills For Developers", description: "Long description of 5 Soft Skills For Developers", descriptionShort: "Short description", day: "DIA 1", linkVideo: "video2-link")
        let schedule3 = Schedule(id: 3, name: "What's New in Xcode 11", description: "Long description of What's New in Xcode 11", descriptionShort: "Short description", day: "DIA 1", linkVideo: "video3-link")
        let schedule4 = Schedule(id: 4, name: "Patreon Revamp", description: "Long description of Patreon Revamp", descriptionShort: "Short description", day: "Thursday", linkVideo: "video4-link")
        let schedule5 = Schedule(id: 5, name: "How I Got a Raise. $60k - $100k", description: "Long description of How I Got a Raise", descriptionShort: "Short description", day: "DIA 1", linkVideo: "video5-link")
        let schedule6 = Schedule(id: 6, name: "Shake Gesture", description: "Long description of Shake Gesture", descriptionShort: "Short description", day: "Saturday", linkVideo: "video6-link")
        let schedule7 = Schedule(id: 7, name: "2019 State of Salaries", description: "Long description of 2019 State of Salaries", descriptionShort: "Short description", day: "DIA 2", linkVideo: "video7-link")
        let schedule8 = Schedule(id: 8, name: "How to Build Your App Wirelessly", description: "Long description of How to Build Your App Wirelessly", descriptionShort: "Short description", day: "DIA 2", linkVideo: "video8-link")
        let schedule9 = Schedule(id: 9, name: "Swift News 70", description: "Long description of Swift News 70", descriptionShort: "Short description", day: "DIA 2", linkVideo: "video9-link")
        let schedule10 = Schedule(id: 10, name: "Video 10", description: "Long description of Video 10", descriptionShort: "Short description", day: "DIA 2", linkVideo: "video10-link")

        return [schedule1, schedule2, schedule3, schedule4, schedule5, schedule6, schedule7, schedule8, schedule9, schedule10]
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
        print(schedule)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = schedule.name
        cell.descriptionLabel.text = "descripcion escion \(schedule.descriptionShort)"
        
        //cell.imageViewPhoto =
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "ponenteDetailSegue", sender: schedules[indexPath.row])
    }
    
    
    
    
}
