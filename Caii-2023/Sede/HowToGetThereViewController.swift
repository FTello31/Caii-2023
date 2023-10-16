//
//  HowToGetThereViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 12/10/23.
//

import UIKit

class HowToGetThereViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func openMaps(_ sender: Any) {
        let lat = "-12.086198043916072"
        let long = "-77.00027622226314"
        let latDouble = Double(lat)!
        let longDouble = Double(long)!
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            //if phone has an app
            if let url = URL(string:    "comgooglemaps-x-callback://?saddr=&daddr=\(latDouble),\(longDouble)&directionsmode=driving") {
                UIApplication.shared.open(url, options: [:])
            }}
        else {
            //Open in browser
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(latDouble),\(longDouble)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
            }
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
