//
//  HomeViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 7/10/23.
//

import UIKit

class HomeViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "HOME22"
        // Do any additional setup after loading the view.
        
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
