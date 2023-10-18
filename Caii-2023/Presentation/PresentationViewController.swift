//
//  PresentationViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 15/10/23.
//

import UIKit

class PresentationViewController: UIViewController {

    @IBOutlet weak var watchVideoBtn: UIButton!
    @IBOutlet weak var whiteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        // Do any additional setup after loading the view.
        whiteView.layer.cornerRadius = 16
        watchVideoBtn.layer.cornerRadius = 30
        watchVideoBtn.layer.masksToBounds = true
    }
    

    @IBAction func onClickWatchVideo(_ sender: UIButton) {
        let youtubeId = "daI3lBeZgqM"
        if let youtubeURL = URL(string: "youtube://\(youtubeId)"),
                UIApplication.shared.canOpenURL(youtubeURL) {
                // redirect to app
                UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
            } else if let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(youtubeId)") {
                // redirect through safari
                UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
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
