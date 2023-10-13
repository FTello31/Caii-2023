//
//  GalleryViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 13/10/23.
//

import UIKit

class GalleryViewController: UIViewController {

    var filters = ["Conferencia","Panel","Foro","Coloquio"]

    var gallery : [UIImage] = []
        
    @IBOutlet weak var collectionGallery: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gallery=fetchData()
        collectionGallery.dataSource=self
        collectionGallery.delegate=self
        
        // Do any additional setup after loading the view.
    }
    

    
    func fetchData() -> [UIImage] {
        let video1 = UIImage(named: "Presentacion_main_image")
        let video2 = UIImage(named: "Presentacion_main_image")
        let video3 = UIImage(named: "Presentacion_main_image")
        let video4 = UIImage(named: "Presentacion_main_image")
        let video5 = UIImage(named: "Presentacion_main_image")
        let video6 = UIImage(named: "Presentacion_main_image")
        let video7 = UIImage(named: "Presentacion_main_image")
        let video8 = UIImage(named: "Presentacion_main_image")
        let video9 = UIImage(named: "Presentacion_main_image")
        let video10 = UIImage(named: "Presentacion_main_image")

        return [video1!, video2!, video3!, video4!, video5!, video6!, video7!, video8!, video9!, video10!]
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


extension GalleryViewController: UICollectionViewDelegate,UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as? FilterViewCell
        //            else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(ofType: GalleryCollectionViewCell.self, for: indexPath)
        cell.imageView.image = gallery[indexPath.item]

//        if cell.isSelected {
//            cell.labelFilterName.textColor = .white
//            cell.viewFilter.backgroundColor = .black
//        } else {
//            cell.labelFilterName.textColor = .black
//            cell.viewFilter.backgroundColor = .white
//        }
        cell.tag = indexPath.row
        return cell
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! FilterViewCell
//        cell.isSelected = true
//        cell.labelFilterName.textColor = .white
//        cell.viewFilter.backgroundColor = .black
//        
//        filterPonentes(category: cell.labelFilterName.text!)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.cellForItem(at: indexPath) as? FilterViewCell else { return }
//        cell.isSelected = false
//        cell.labelFilterName.textColor = .black
//        cell.viewFilter.backgroundColor = .white
//        
//    }
    
}
