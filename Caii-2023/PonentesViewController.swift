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
        
    //    var ponentes: [PonentesData] = []
    var ponentes: [String] = []

    
    @IBOutlet weak var collectionViewFilter: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
//    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")

        loadPonentes()
    }
    
    
    func loadPonentes(){
//        ponentes = []
        ponentes =  ["Conferencia","Conferencia","Conferencia","Panel","Foro"]

        print(ponentes)
        
        DispatchQueue.main.async {
               self.tableView.reloadData()
//            let indexPath = IndexPath(row: self.ponentes.count - 1, section: 0)
//            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
//        ponentes = [
//            {id:1,name:"gerardo",category:"Conferencia"},
//
//            {"id":1,"name":"gerardo","categoria":"Conferencia"},
//            {"id":1,"name":"gerardo","Category":"Conferencia"},
//        ]
    }
    
    func filterPonentes( category: String){
        ponentes =  ["Conferencia","Conferencia","Conferencia","Panel","Foro"]

        print(ponentes)

        ponentes = ponentes.filter{ ponente in
          return ponente == category
        }

        print(ponentes)

        
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
        
        filterPonentes(category: cell.labelFilterName.text ?? "aaa")
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
        cell.nameLabel.text = ponente
        cell.descriptionLabel.text = "descriocion escion \(ponente)"
        
        //cell.imageViewPhoto =
      
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ponentes.count
    }
    
}
