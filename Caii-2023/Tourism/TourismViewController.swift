//
//  TurismViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 11/10/23.
//

import UIKit


class TourismViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionViewFilter: UICollectionView!
    
    var tourismPlaces: [TourismPlaces] = []
    var restaurants: [Restaurants] = []
    
    var filters = ["LUGARES TURÍSTICOS","RESTAURANTES"]
    var tableList: [ListItem] = []
    var nextSegue: String = "tourismPlacesSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        loadLists()
        configureTableView()
        setFirstFilterSelected()
    }
    
    func loadLists(){
        tourismPlaces =  fetchTourismPlaces()
        restaurants =  fetchRestaurants()
    }
    
    func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    
    func setFirstFilterSelected(){
        let indexPath = self.collectionViewFilter.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0)
        collectionViewFilter.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.left)
        filterList(category: filters[0])
    }
    
    
    func filterList(category: String){
        loadLists()
        if (category.elementsEqual("LUGARES TURÍSTICOS") ){
            nextSegue = "tourismPlacesSegue"
            tableList = tourismPlaces
        }else{
            nextSegue = "restaurantsSegue"
            tableList = restaurants
        }
        self.tableView.reloadData()
    }
    
    func fetchTourismPlaces() -> [TourismPlaces] {
        // Crea y devuelve una lista de lugares turísticos
        // Puedes llenar estos datos según tus necesidades
        let place1 = TourismPlaces(name: "Place 1", id: 1, description: "Description 1")
        let place2 = TourismPlaces(name: "Place 2", id: 2, description: "Description 2")
        let place3 = TourismPlaces(name: "Place 3", id: 3, description: "Description 3")
        
        return [place1, place2, place3]
    }
    
    func fetchRestaurants() -> [Restaurants] {
        // Crea y devuelve una lista de restaurantes
        // Puedes llenar estos datos según tus necesidades
        let restaurant1 = Restaurants(id: 1, name: "Restaurant 1", description: "Description 1", location: "Location 1", website: "Website 1")
        let restaurant2 = Restaurants(id: 2, name: "Restaurant 2", description: "Description 2", location: "Location 2", website: "Website 2")
        let restaurant3 = Restaurants(id: 3, name: "Restaurant 3", description: "Description 3", location: "Location 3", website: "Website 3")
        
        return [restaurant1, restaurant2, restaurant3]
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is TourismPlacesViewController {
            let vc = segue.destination as? TourismPlacesViewController
            let detailToSend = sender as? TourismPlaces
//            print("***")
            vc?.detail = detailToSend
            vc?.title = "title from prepare toyris, "
            
        }
        if segue.destination is RestaurantsViewController {
            let vc = segue.destination as? RestaurantsViewController
            let detailToSend = sender as? Restaurants
//            print("***")
            vc?.detail = detailToSend
            vc?.title = "title from prepare rest"
            
        }
    }
    
}


extension TourismViewController:  UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        
        filterList(category: cell.labelFilterName.text!)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FilterViewCell else { return }
        cell.isSelected = false
        cell.labelFilterName.textColor = .black
        cell.viewFilter.backgroundColor = .white
        
    }
}


extension TourismViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let element = tableList[indexPath.row]
        print(element)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = element.name
        cell.descriptionLabel.text = "descripcion escion \(element.name)"
        
        //cell.imageViewPhoto =
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: nextSegue, sender: tableList[indexPath.row])
    }
    
    
}
