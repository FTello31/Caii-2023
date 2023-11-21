//
//  RestaurantsViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 11/10/23.
//

import UIKit

class RestaurantsViewController: UIViewController {

    var detail: Restaurants?

    @IBOutlet weak var aboutWhiteViewContainer: UIView!
    @IBOutlet weak var infoWhiteViewContainer: UIView!
    @IBOutlet weak var locationWhiteViewContainer: UIView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantDescriptionLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    
    @IBOutlet weak var locationInfoLabel: UILabel!
//    @IBOutlet weak var informationLabel: UILabel!

    @IBOutlet weak var informationLabel2: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()

        setup()
        // Do any additional setup after loading the view.
        redView.layer.cornerRadius = 16
        locationWhiteViewContainer.layer.cornerRadius = 16
        infoWhiteViewContainer.layer.cornerRadius = 16
        aboutWhiteViewContainer.layer.cornerRadius = 16
        
        informationLabel2.isUserInteractionEnabled = true
        informationLabel2.isSelectable = true
        informationLabel2.dataDetectorTypes = .link
        informationLabel2.isEditable = false
    }
    
    func setup(){
        if let detailUnwrapped = detail {
                print(detailUnwrapped)
            restaurantNameLabel.text = detailUnwrapped.name
//            timeLabel.text = String (detailUnwrapped.id)
            restaurantDescriptionLabel.text = String(localized: """
Especialidad: \(detailUnwrapped.description)
Horario de atencion: \(detailUnwrapped.hours)
""")
            locationInfoLabel.text = detailUnwrapped.location
            informationLabel2.text = detailUnwrapped.website
            restaurantImageView.image = UIImage(named: detailUnwrapped.image)
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
