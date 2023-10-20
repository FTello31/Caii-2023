//
//  ViewController.swift
//  CollectionViewDynamicSizing
//
//  Created by Shankar on 03/03/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit

class PonentesViewController: UIViewController {
    
    var filters = ["Conferencia","Panel","Foro","Coloquio"]
    
    var ponentes: [PonentesData] = []
    //    var ponentes: [String] = []
    
    
    @IBOutlet weak var collectionViewFilter: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavbar()
        loadPonentes()
        configureTableView()
        setFirstFilterSelected()
    }
    
    func loadPonentes(){
        ponentes =  fetchData()
    }
    
    func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    
    func setFirstFilterSelected(){
        let indexPath = self.collectionViewFilter.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0)
        collectionViewFilter.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        filterPonentes(category: filters[0])
    }
    
    
    func filterPonentes( category: String){
        loadPonentes()
        
        ponentes = ponentes.filter { ponente in
            return ponente.category == category
        }
        
        self.tableView.reloadData()
        
    }
    
    func fetchData() -> [PonentesData] {
        let data1 = PonentesData(name: "John Doe", id: 1, category: "Conferencia", description: "A comprehensive talk on iOS development, covering the latest trends, best practices, and real-world examples.", eventName: "iOS Development", timeLabel: "9:00 AM", dateLabel: "2023-10-18", placeLabel: "Room A")
        let data2 = PonentesData(name: "Jane Smith", id: 2, category: "Conferencia", description: "An insightful discussion on design principles, including user interface design, user experience, and usability testing.", eventName: "Design Principles", timeLabel: "10:30 AM", dateLabel: "2023-10-18", placeLabel: "Room B")
        let data3 = PonentesData(name: "Bob Johnson", id: 3, category: "Conferencia", description: "Discover valuable tips for Swift programming, including performance optimization, code structure, and error handling.", eventName: "Swift Tips", timeLabel: "11:45 AM", dateLabel: "2023-10-18", placeLabel: "Room C")
        let data4 = PonentesData(name: "Alice Brown", id: 4, category: "Panel", description: "Join our expert panel for a detailed discussion on app monetization strategies, ad revenue, and subscription models.", eventName: "App Monetization", timeLabel: "2:00 PM", dateLabel: "2023-10-18", placeLabel: "Auditorium")
        let data5 = PonentesData(name: "Chris Wilson", id: 5, category: "Panel", description: "Explore key aspects of career development for developers, including job growth, negotiation, and skill enhancement.", eventName: "Career Development", timeLabel: "3:30 PM", dateLabel: "2023-10-18", placeLabel: "Auditorium")
        let data6 = PonentesData(name: "Eva Lee", id: 6, category: "Panel", description: "Learn strategies to improve user experience design, including usability testing, wireframing, and prototyping.", eventName: "User Experience", timeLabel: "4:45 PM", dateLabel: "2023-10-18", placeLabel: "Auditorium")
        let data7 = PonentesData(name: "David Clark", id: 7, category: "Foro", description: "Participate in a dynamic forum discussing the latest industry trends, emerging technologies, and future opportunities.", eventName: "Industry Trends", timeLabel: "10:00 AM", dateLabel: "2023-10-19", placeLabel: "Conference Hall")
        let data8 = PonentesData(name: "Laura Martinez", id: 8, category: "Foro", description: "Discover success stories of startups, their challenges, and their path to growth and profitability.", eventName: "Startup Success", timeLabel: "11:30 AM", dateLabel: "2023-10-19", placeLabel: "Conference Hall")
        let data9 = PonentesData(name: "Michael Anderson", id: 9, category: "Foro", description: "Engage in discussions about various aspects of Swift development, including best practices, libraries, and frameworks.", eventName: "Swift Development", timeLabel: "1:15 PM", dateLabel: "2023-10-19", placeLabel: "Conference Hall")
        let data10 = PonentesData(name: "Sarah Wilson", id: 10, category: "Foro", description: "Explore the impact of new technologies on industries, their applications, and potential disruptions they may bring.", eventName: "New Technologies", timeLabel: "3:00 PM", dateLabel: "2023-10-19", placeLabel: "Conference Hall")
        
        return [data1, data2, data3, data4, data5, data6, data7, data8, data9, data10]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is PonenteDetailViewController {
            let vc = segue.destination as? PonenteDetailViewController
            let detailToSend = sender as? PonentesData
            vc?.detail = detailToSend
        }
        
    }
}

extension PonentesViewController: UICollectionViewDelegate,UICollectionViewDataSource {
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
        
        filterPonentes(category: cell.labelFilterName.text!)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FilterViewCell else { return }
        cell.isSelected = false
        cell.labelFilterName.textColor = .black
        cell.viewFilter.backgroundColor = .white
        
    }
    
}



extension PonentesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ponente = ponentes[indexPath.row]
        print(ponente)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = ponente.name
        cell.descriptionLabel.text = ponente.description
        //        cell.imageViewPhoto = ponente.imagen
        //        cell.imageViewPhoto.image = UIImage(named: "")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ponentes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "ponenteDetailSegue", sender: ponentes[indexPath.row])
    }
    
    
    
    
}
