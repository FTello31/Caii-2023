//
//  TourismPlacesViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 11/10/23.
//

import UIKit

class TourismPlacesViewController: UIViewController {

    var detail: TourismPlaces?

    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var tourismName: UILabel!
    @IBOutlet weak var tourismDescription: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        setup()
        // Do any additional setup after loading the view.
        whiteView.layer.cornerRadius = 16
    }
    
    
    func setup(){
        if let detailUnwrapped = detail {
                print(detailUnwrapped)
            tourismName.text = detailUnwrapped.name
//            timeLabel.text = String (detailUnwrapped.id)
            tourismDescription.text = detailUnwrapped.description
            }
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
