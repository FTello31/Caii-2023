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
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var viewRedContainer: UIView!
    @IBOutlet weak var whiteContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        // Do any additional setup after loading the view.
        setup()
        whiteContainer.layer.cornerRadius = 16
        
    }
    

    func setup(){
        if let detailUnwrapped = detail {
                print(detailUnwrapped)
            ponenteNameLabel.text = detailUnwrapped.name
            eventNameLabel.text = detailUnwrapped.eventName
            timeLabel.text = "Hora: \(detailUnwrapped.timeLabel)"
            dateLabel.text = "Fecha: \(detailUnwrapped.dateLabel)"
            placeLabel.text = "Lugar: \(detailUnwrapped.placeLabel)"
            descriptionLabel.text = detailUnwrapped.description
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
