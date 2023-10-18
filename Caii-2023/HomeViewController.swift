//
//  HomeViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 7/10/23.
//

import UIKit

class HomeViewController: UIViewController {
    let defaults = UserDefaults.standard
    let customFont = UIFont(name: "Franie", size: 14)

    var homeButtons: [HomeButton] = []
    
    @IBOutlet weak var todayLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var mainEventNameLabel: UILabel!
    
    @IBOutlet weak var mainEventPlaceLabel: UILabel!
    
    @IBOutlet weak var mainEventTimeLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        // Do any additional setup after loading the view.
        whiteView.layer.cornerRadius = 15
        logoutBtn.layer.cornerRadius = 30
        logoutBtn.layer.masksToBounds = true
        
        mainEventTimeLabel.font = customFont
        mainEventPlaceLabel.font = customFont

        formatTodayDateLabel()
        
        setupCollectionView()

        fetchData()
    }
    
    func formatTodayDateLabel(){
        let date = Date()

        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "dd MMMM"
        todayLabel.text = formatter.string(from: date)
        print(formatter.string(from: date))
        
        
    }
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func fetchData() {
        let button1 = HomeButton(id: 1, name: "Presentación", color: "PrimaryCAII", image: "icons8-presentation-60", viewControllerName: "PresentationViewController")
           let button2 = HomeButton(id: 2, name: "Mi Programa", color: "GreyCAII", image: "icons8-schedule-60", viewControllerName: "ScheduleViewController")
           let button3 = HomeButton(id: 3, name: "Sede", color: "YellowCAII", image: "icons8-library-60", viewControllerName: "SedeMainViewController")
           let button4 = HomeButton(id: 4, name: "Ponentes", color: "LightblueCAII", image: "icons8-people-60", viewControllerName: "PonentesViewController")
           let button5 = HomeButton(id: 5, name: "Turismo", color: "BlueCAII", image: "icons8-food-60", viewControllerName: "TourismViewController")
           let button6 = HomeButton(id: 6, name: "Contactos de emergencia", color: "PrimaryCAII", image: "icons8-emergency-60", viewControllerName: "EmergencyPhonesViewController")
           let button7 = HomeButton(id: 7, name: "CAII en vivo", color: "BlueCAII", image: "icons8-live-video-on-60", viewControllerName: "CAIIViewController")

        if(defaults.string(forKey: "version")!.elementsEqual("offline")){
            homeButtons = [button1, button2, button3, button4, button5, button6]
        }else if(defaults.string(forKey: "version")!.elementsEqual("online")){
            homeButtons = [button1, button2, button7, button4, button3, button6]
        }
    }
    
    
    @IBAction func showPopUp(_ sender: UIButton) {
        let avc : ReusablePopUpViewController = ReusablePopUpViewController()
        avc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        avc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        avc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        //print("Freaking tab bar below ---")
        //print(self.navigationController?.tabBarController?.tabBar.isHidden)
        //self.navigationController?.tabBarController?.tabBar.isHidden = true
        present(avc, animated: true)
    }
    
    @IBAction func onLogoutPressed(_ sender: UIButton) {
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        print(Array(defaults.dictionaryRepresentation().keys).count)
        
        // Pop to the root view controller (LoginViewController)
        //self.navigationController?.popToRootViewController(animated: true)
        
        goToLoginStoryboard()
    }
    
    
    
    
    func goToLoginStoryboard() -> Void {
        let storyboard = UIStoryboard(name: "Login", bundle: .main)
        
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
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

extension HomeViewController:
    UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//            let columns = 3
//            let width = Int(UIScreen.main.bounds.width)
//            let side = width / columns
//            let rem = width % columns
//            let addOne = indexPath.row % columns < rem
//            let ceilWidth = addOne ? side + 1 : side
//            return CGSize(width: ceilWidth, height: side)
//        
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeButtons.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: HomeButtonCollectionViewCell.self, for: indexPath)
        
        cell.backgroundIcon.backgroundColor = UIColor(named: homeButtons[indexPath.item].color)
        cell.icon.image = UIImage(named: homeButtons[indexPath.item].image)
        cell.nameLabel.text = homeButtons[indexPath.item].name
        
        cell.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let cell = collectionView.cellForItem(at: indexPath) as! HomeButtonCollectionViewCell
//        cell.isSelected = true
        
        if(homeButtons[indexPath.item].viewControllerName.elementsEqual("CAIIViewController")) {
            let youtubeId = "daI3lBeZgqM"
            if let youtubeURL = URL(string: "youtube://\(youtubeId)"),
                    UIApplication.shared.canOpenURL(youtubeURL) {
                    // redirect to app
                    UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
                } else if let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(youtubeId)") {
                    // redirect through safari
                    UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
                }
            
        }else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: homeButtons[indexPath.item].viewControllerName) as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
      
    }
    
       
}
