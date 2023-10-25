//
//  ScheduleDetailViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 17/10/23.
//

import UIKit

class ScheduleDetailViewController: UIViewController {
    
    var detail: EventD?
    @IBOutlet weak var titleNameLabel: UILabel!
    
    @IBOutlet weak var descriptionShortLabel: UILabel!
    
    @IBOutlet weak var watchOnlineBtn: UIButton!
    
    @IBOutlet weak var descriptionLongLabel: UILabel!
    
    @IBOutlet weak var firstWhiteView: UIView!
    
    @IBOutlet weak var secondWhiteView: UIView!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupViewStyles()
        setupData()
        
    }
    
    
    
    func setupData(){
        if let detailUnwrapped = detail {
            titleNameLabel.text = detailUnwrapped.titulo
            descriptionShortLabel.text = 
"""
Hora: \(detailUnwrapped.hora_inicio) - \(detailUnwrapped.hora_final)
Fecha: \(detailUnwrapped.fecha_desde.components(separatedBy: " ").first ?? detailUnwrapped.fecha_desde)
Lugar: \(detailUnwrapped.lugar)
"""
            descriptionLongLabel.text = detailUnwrapped.subtitulo
        }
    }
    
    
    func setupViewStyles(){
        firstWhiteView.layer.cornerRadius = 16
        secondWhiteView.layer.cornerRadius = 16
        
        watchOnlineBtn.layer.cornerRadius = 20
        watchOnlineBtn.layer.masksToBounds = true
        
        watchOnlineBtn.titleLabel?.textAlignment = .center
        
    }
    
    
    @IBAction func onClickWatchOnline(_ sender: UIButton) {
        
        print("*****",sender)
        
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
