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
    
    var filters = [String(localized: "LUGARES TURÍSTICOS"),String(localized: "RESTAURANTES")]
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
        if (category.elementsEqual(String(localized:"LUGARES TURÍSTICOS")) ){
            nextSegue = "tourismPlacesSegue"
            tableList = tourismPlaces
        }else{
            nextSegue = "restaurantsSegue"
            tableList = restaurants
        }
        self.tableView.reloadData()
    }
    
    func fetchTourismPlacesData() -> [TourismPlaces] {
        let place2 = TourismPlaces(hours: "", image: "catedral-limaImage", name: "Catedral de Lima", id: 2, description: String(localized: "Majestuoso ejemplo del barroco colonial, la deslumbrante catedral de Lima destaca con sus altas torres de pizarra en el centro histórico de la ciudad. Bastión de la fe católica en el Perú, el templo mayor vigila la vida de la ciudad desde hace casi medio milenio. Su arquitectura y ornamentos dan una idea de la importancia del virreinato del Perú para la corona española en tiempos de conquista."))

        let place3 = TourismPlaces(hours: "", image: "museo-larco-limaImage", name: "Museo Larco", id: 3, description: String(localized: "Instalado en una casona virreinal del siglo XVIII, el Museo Larco es uno de los más visitados de Lima. Cinco milenios de historia están resguardados en la colección de distintas culturas que fueron recopiladas y adquiridas por dos generaciones de la familia Larco: Rafael Larco Herrera y su hijo, Rafael Larco Hoyle. En 1923 abrió el museo con los objetos que el hijo, arqueólogo, fue recuperando en todo el Perú."))

        let place4 = TourismPlaces(hours: "", image: "circuito-magico-del-agua-limaImage", name: "Parque de la Reserva", id: 4, description: String(localized: "Ubicado en el corazón de Lima, es un conjunto de fuentes mecanizadas y operadas por computador que ofrece un bellísimo espectáculo de luz, sonido y color. Llamado popularmente Circuito Mágico del Agua, ostenta el récord Guiness de ser el mayor circuito de fuentes en un parque público en el mundo."))

        let place5 = TourismPlaces(hours: "", image: "huaca-pucllanaImage", name: "Huaca Pucllana", id: 5, description: String(localized: "Monumental conjunto arqueológico, la Huaca Pucllana es la más impresionante y conservada de las huellas de la civilización Lima en el área urbana de la capital del Perú. Un museo de sitio, reproducciones de hábitos culturales de sus pobladores, y recorridos guiados son parte de la oferta del lugar, cuyo cuidado y explotación es vigilado con celo por el gobierno peruano."))


        return [place2, place3, place4, place5]
    }

    func fetchRestaurantsData() -> [Restaurants] {
        let restaurant1 = Restaurants(image: "longhornImage", id: 1, name: "Long Horn", description: String(localized: "Carnes, pastas"), hours: "12:00 hrs. - 24:00 hrs.", location: "Vittore Carpaccio 210, San Borja", website: "http://longhorn.com.pe/")
        let restaurant2 = Restaurants(image: "norkysImage", id: 2, name: "Norkys", description: String(localized: "Peruana"), hours: "12:00 hrs. - 22:00 hrs.", location: "Av. Aviación 2968 Urb.San Borja Sur – San Borja", website: "https://www.norkys.pe/")
        let restaurant3 = Restaurants(image: "pizzahutImage", id: 3, name: "Pizza Hut", description: String(localized: "Italiana, fusión"), hours: "12:00 hrs. - 22:00 hrs.", location: "Centro Comercial La Rambla, Vittore Carpaccio 241", website: "https://www.pizzahut.com.pe/")
        let restaurant4 = Restaurants(image: "edoImage", id: 4, name: "Edo Sushi Bar", description: String(localized: "Japonesa, fusión"), hours: "12:00 hrs. - 22:00 hrs.", location: "Vittore Carpaccio, San Borja 15036", website: "https://www.edosushibar.com/")
        let restaurant5 = Restaurants(image: "huancahuasiImage", id: 5, name: "Huancahuasi", description: String(localized: "Peruana, Latina"), hours: "08:00 hrs. - 18:00 hrs.", location: "Av. Javier Prado Este 1405 Santa Catalina", website: "https://www.huancahuasi.com/")
        
        return [restaurant1, restaurant2, restaurant3, restaurant4, restaurant5]
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
//            vc?.title = "title from prepare toyris, "
            
        }
        if segue.destination is RestaurantsViewController {
            let vc = segue.destination as? RestaurantsViewController
            let detailToSend = sender as? Restaurants
//            print("***")
            vc?.detail = detailToSend
//            vc?.title = "title from prepare rest"
            
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
        cell.imageViewPhoto.image = UIImage(named: element.image)
        cell.imageViewPhoto.contentMode = .scaleAspectFill
        if(!element.hours.isEmpty){
            cell.descriptionLabel.text = String(localized:"""
Especialidad: \(element.description)
Horario de atencion: \(element.hours)
""")
        }
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
