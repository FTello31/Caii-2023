//
//  SedeViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 12/10/23.
//

import UIKit

class SedeMainViewController: UIViewController {

    var filters = ["¿DÓNDE ES?","¿CÓMO LLEGAR?","GALERÍA"]

    
    @IBOutlet weak var collectionViewFilter: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    
    private lazy var whereIsViewController: WhereIsViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "WhereIsViewController") as! WhereIsViewController

        return viewController
    }()

    private lazy var howToGetThereViewController: HowToGetThereViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "HowToGetThereViewController") as! HowToGetThereViewController

        return viewController
    }()
    
    
    private lazy var galleryViewController: GalleryViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        setFirstFilterSelected()

        // Do any additional setup after loading the view.
    }
    
    
    func setFirstFilterSelected(){
        let indexPath = self.collectionViewFilter.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0)
        collectionViewFilter.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
//        filterPonentes(category: filters[0])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func updateView(category: String){
        if category == filters[0] {
//            containerView.addSubview(whereIsViewController.view)
            add(asChildViewController: whereIsViewController)
//            remove(asChildViewController: howToGetThereViewController)
//            remove(asChildViewController: galleryViewController)
        } else if(category == filters[1]) {
//            containerView.addSubview(howToGetThereViewController.view)
          add(asChildViewController: howToGetThereViewController)
//            remove(asChildViewController: whereIsViewController)
//            remove(asChildViewController: galleryViewController)
        } else if(category == filters[2]) {
//            containerView.addSubview(galleryViewController.view)
            add(asChildViewController: galleryViewController)
//            remove(asChildViewController: whereIsViewController)
//            remove(asChildViewController: howToGetThereViewController)
        }
    }
    
    
    private func add(asChildViewController viewController: UIViewController) {
            // Add Child View as Subview
        containerView.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }

}

extension SedeMainViewController:
    UICollectionViewDelegate,UICollectionViewDataSource {
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
            
//            filterPonentes(category: cell.labelFilterName.text!)
            updateView(category: cell.labelFilterName.text!)
        }
        
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? FilterViewCell else { return }
            cell.isSelected = false
            cell.labelFilterName.textColor = .black
            cell.viewFilter.backgroundColor = .white
            
        }
        
    }
