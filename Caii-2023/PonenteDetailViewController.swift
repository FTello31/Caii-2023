//
//  PonenteDetailViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 11/10/23.
//

import UIKit

class PonenteDetailViewController: UIViewController {
    
    var detail: PonentesData?

    @IBOutlet weak var ponenteNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DETAIL11111"
        // Do any additional setup after loading the view.
        if let detailUnwrapped = detail {
                print(detailUnwrapped)
            ponenteNameLabel.text = detailUnwrapped.name
            timeLabel.text = String (detailUnwrapped.id)
            descriptionLabel.text = detailUnwrapped.category
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
