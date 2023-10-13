//
//  RestaurantsViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 11/10/23.
//

import UIKit

class RestaurantsViewController: UIViewController {

    var detail: Restaurants?

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()

        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        if let detailUnwrapped = detail {
                print(detailUnwrapped)
            restaurantNameLabel.text = detailUnwrapped.name
//            timeLabel.text = String (detailUnwrapped.id)
            restaurantDescriptionLabel.text = detailUnwrapped.description
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
