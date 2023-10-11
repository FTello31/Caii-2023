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
        //        title = "Ponentes"
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
        collectionViewFilter.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.left)
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
        let video1 = PonentesData(name: "No Storyboards", id: 1, category: "Conferencia")
        let video2 = PonentesData(name: "5 Soft Skills For Developers", id: 2, category: "Conferencia")
        let video3 = PonentesData(name: "What's New in Xcode 11", id: 3, category: "Conferencia")
        let video4 = PonentesData(name: "Patreon Revamp", id: 4, category: "Panel")
        let video5 = PonentesData(name: "How I Got a Raise. $60k - $100k", id: 5, category: "Panel")
        let video6 = PonentesData(name: "Shake Gesture", id: 6, category: "Panel")
        let video7 = PonentesData(name: "2019 State of Salaries", id: 7, category: "Foro")
        let video8 = PonentesData(name: "How to Build Your App Wirelessly", id: 8, category: "Foro")
        let video9 = PonentesData(name: "Swift News 70", id: 9, category: "Foro")
        let video10 = PonentesData(name: "Video 10", id: 10, category: "Foro")
        
        return [video1, video2, video3, video4, video5, video6, video7, video8, video9, video10]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is PonenteDetailViewController {
            let vc = segue.destination as? PonenteDetailViewController
            let detailToSend = sender as? PonentesData
//            print("***")
            vc?.detail = detailToSend
            vc?.title = "title from prepare "
            
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
        cell.descriptionLabel.text = "descripcion escion \(ponente.name)"
        
        //cell.imageViewPhoto =
        
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
