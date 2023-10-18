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
        tourismPlaces =  fetchTourismPlacesData()
        restaurants =  fetchRestaurantsData()
    }
    
    func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    
    func setFirstFilterSelected(){
        let indexPath = self.collectionViewFilter.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0)
        collectionViewFilter.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
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
    
    func fetchTourismPlacesData() -> [TourismPlaces] {
        let place1 = TourismPlaces(name: "Historic Museum", id: 1, description: "Explore the rich history and artifacts of our city at the Historic Museum.")
        let place2 = TourismPlaces(name: "Botanical Garden", id: 2, description: "Enjoy a peaceful stroll through the lush greenery and vibrant flowers at the Botanical Garden.")
        let place3 = TourismPlaces(name: "Scenic Overlook", id: 3, description: "Take in breathtaking views of the city and surrounding landscapes from the Scenic Overlook.")
        let place4 = TourismPlaces(name: "Art Gallery", id: 4, description: "Discover contemporary and classical art in our Art Gallery.")
        let place5 = TourismPlaces(name: "Nature Reserve", id: 5, description: "Experience the beauty of nature with hiking trails in the Nature Reserve.")
        let place6 = TourismPlaces(name: "Zoo Park", id: 6, description: "Visit the animals and learn about wildlife at the Zoo Park.")

        return [place1, place2, place3, place4, place5, place6]
    }

    func fetchRestaurantsData() -> [Restaurants] {
        let restaurant1 = Restaurants(id: 1, name: "Taste of Italy", description: "Savor authentic Italian cuisine in a cozy atmosphere.", location: "123 Main Street", website: "www.tasteofitaly.com")
        let restaurant2 = Restaurants(id: 2, name: "Spice Bazaar", description: "Experience the flavors of the world with our diverse menu.", location: "456 Oak Avenue", website: "www.spicebazaar.com")
        let restaurant3 = Restaurants(id: 3, name: "Seafood Harbor", description: "Indulge in fresh seafood dishes by the waterfront.", location: "789 Harbor Drive", website: "www.seafoodharbor.com")
        let restaurant4 = Restaurants(id: 4, name: "Mediterranean Delights", description: "Enjoy Mediterranean specialties and a selection of fine wines.", location: "234 Beach Boulevard", website: "www.mediterraneandelights.com")
        let restaurant5 = Restaurants(id: 5, name: "Sushi Fusion", description: "Experience a fusion of flavors with our sushi and Japanese cuisine.", location: "567 Pine Street", website: "www.sushifusion.com")
        let restaurant6 = Restaurants(id: 6, name: "BBQ Smokehouse", description: "Satisfy your cravings with our smoky and savory barbecue dishes.", location: "890 Oak Lane", website: "www.bbqsmokehouse.com")

        return [restaurant1, restaurant2, restaurant3, restaurant4, restaurant5, restaurant6]
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
        cell.descriptionLabel.text = element.description
        
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
