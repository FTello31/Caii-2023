//
//  ScheduleDetailViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 17/10/23.
//

import UIKit

class ScheduleDetailViewController: UIViewController {
    
    var detail: EventD?
    var buttonLink: String = ""
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
            String(localized: """
Hora: \(detailUnwrapped.hora_inicio) - \(detailUnwrapped.hora_final)
Fecha: \(detailUnwrapped.fecha_desde.components(separatedBy: " ").first ?? detailUnwrapped.fecha_desde)
Lugar: \(detailUnwrapped.lugar)
""")

            descriptionLongLabel.text = detailUnwrapped.subtitulo
            if(detailUnwrapped.enlace == nil){
                watchOnlineBtn.isHidden = true
            }else {
                buttonLink = detailUnwrapped.enlace!
            }
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
        if(buttonLink != ""){
            if let zoomURL = URL(string: buttonLink) {
                // redirect through safari
                UIApplication.shared.open(zoomURL, options: [:], completionHandler: nil)
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
