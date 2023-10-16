//
//  LoginViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 7/10/23.
//

import UIKit
import SwiftyGif


class LoginViewController: UIViewController {
    
    let logoAnimationView = LogoAnimationView()

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var inputDNI: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
    }
    
    
    
    @IBAction func onLoginPressed(_ sender: UIButton) {
        
        
        if(inputDNI.text == "1"){
            saveAuthenticatedUser(inputDNI.text! , "online")
            goToMainStoryboard();
        } else if(inputDNI.text == "2"){
            saveAuthenticatedUser(inputDNI.text! , "offline")
            goToMainStoryboard();
        } else{
            let alert = UIAlertController(title: "Hey", message: "DNI input esta vacio", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func saveAuthenticatedUser(_ dni: String,_ version:String) -> Void {
        defaults.set(dni, forKey: "isLoggedIn")
        defaults.set(version, forKey: "version")
    }
    
    
    func goToMainStoryboard() -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
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


extension LoginViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
    }
}
