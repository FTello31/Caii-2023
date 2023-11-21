//
//  EmergencyPhonesViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 11/10/23.
//

import UIKit

class EmergencyPhonesViewController: UIViewController {
    
    var filters = ["Seguridad","Salud"]
    
    var emergencyPhones:[EmergencyPhones] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionViewFilter: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        
        loadEmergencyPhones()
        configureTableView()
        setFirstFilterSelected()
        // Do any additional setup after loading the view.
    }
    
    func loadEmergencyPhones(){
        emergencyPhones =  fetchData()
    }
    
    func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "EmergencyPhonesTableViewCell", bundle: nil), forCellReuseIdentifier: "EmergencyReusableCell")
    }
    
    
    func setFirstFilterSelected(){
        let indexPath = self.collectionViewFilter.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0)
        collectionViewFilter.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        filterEmergencyPhones(category: filters[0])
    }
    
    func filterEmergencyPhones( category: String){
        loadEmergencyPhones()
        
        emergencyPhones = emergencyPhones.filter { emergencyPhone in
            return emergencyPhone.category == category
        }
        
        self.tableView.reloadData()
        
    }
    
    func fetchData() -> [EmergencyPhones] {
        let video1 = EmergencyPhones(name: "Central Policial", number: 105, category: "Seguridad")
            let video2 = EmergencyPhones(name: "Defensa Civil", number: 110, category: "Seguridad")
            let video3 = EmergencyPhones(name: "Cruz Roja", number: 115, category: "Seguridad")
            let video4 = EmergencyPhones(name: "Bomberos", number: 116, category: "Seguridad")
            let video5 = EmergencyPhones(name: "Serenazgo San Borja", number: +5116311000, category: "Seguridad")
            let video6 = EmergencyPhones(name: "Clínica San Borja", number: +5116355000, category: "Salud")
            let video7 = EmergencyPhones(name: "Clínica Internacional", number: +5116196161, category: "Salud")
            let video8 = EmergencyPhones(name: "Clínica Bienestar Medico y Tecnologia - BMT", number: +5115002100, category: "Salud")
            let video9 = EmergencyPhones(name: "Clínica San Borja Salud 24 Horas", number: +51998870012, category: "Salud")
            let video10 = EmergencyPhones(name: "Clínica Javier Prado", number: +5112114141, category: "Salud")
            let video11 = EmergencyPhones(name: "Clínica Ricardo Palma", number: +5112242224, category: "Salud")

            return [video1, video2, video3, video4, video5, video6, video7, video8, video9, video10, video11]
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

extension EmergencyPhonesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        
        filterEmergencyPhones(category: cell.labelFilterName.text!)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FilterViewCell else { return }
        cell.isSelected = false
        cell.labelFilterName.textColor = .black
        cell.viewFilter.backgroundColor = .white
    }
    
}


extension EmergencyPhonesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emergencyPhones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emergencyPhone = emergencyPhones[indexPath.row]
//        print(emergencyPhone)
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmergencyReusableCell", for: indexPath) as! EmergencyPhonesTableViewCell
        cell.nameLabel.text = emergencyPhone.name
        //https://stackoverflow.com/questions/39947076/uitableviewcell-buttons-with-action
        //using closures
        cell.buttonPressed = {
                  //Code
            self.callNumber(phoneNumber: String(emergencyPhone.number))
                   }
        return cell
    }
    
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "tel://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    ////        let cell = tableView.cellForRow(at: indexPath)
    //        tableView.deselectRow(at: indexPath, animated: true)
    //
    //        performSegue(withIdentifier: "ponenteDetailSegue", sender: ponentes[indexPath.row])
    //    }
    
    
}
