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
    
    @IBOutlet weak var imageViewPhoto: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        // Do any additional setup after loading the view.
        setup()
        whiteContainer.layer.cornerRadius = 16
        imageViewPhoto.layer.cornerRadius = min(imageViewPhoto.frame.size.height, imageViewPhoto.frame.size.width) / 2.0

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
            imageViewPhoto.image = UIImage(named: detailUnwrapped.image)
            imageViewPhoto.contentMode = .scaleAspectFill
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
