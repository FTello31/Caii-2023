//
//  WhereIsViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 12/10/23.
//

import UIKit

class WhereIsViewController: UIViewController {

    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var imageSedeView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        whiteView.layer.cornerRadius = 16
        imageSedeView.layer.cornerRadius = 16
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
