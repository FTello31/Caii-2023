//
//  LoginViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 7/10/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    //    let logoAnimationView = LogoAnimationView()
    
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var segmentedControlContainerView: UIView!
    @IBOutlet weak var segmentedControlDni: UISegmentedControl!
    @IBOutlet weak var inputDNI: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.addSubview(logoAnimationView)
        //
        //        logoAnimationView.pinEdgesToSuperView()
        //        logoAnimationView.logoGifImageView.delegate = self
        
        // Do any additional setup after loading the view.
        setupStyles()        
    }
    
    func presentGif(){
        print("aaaaa")
        let avc : LoginAnimationViewController = LoginAnimationViewController()
        avc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        avc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        //        avc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        present(avc, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        presentGif()
        
        //        logoAnimationView.logoGifImageView.startAnimatingGif()
        
        //        segmentedControlDni.layer.cornerRadius = 30;
        //        segmentedControlDni.layer.borderColor = UIColor.blue.cgColor;
        //        segmentedControlDni.layer.borderWidth = 3.0;
        //        segmentedControlDni.layer.masksToBounds = true;
    }
    
    func setupStyles(){
        loginBtn.layer.cornerRadius = 30
        loginBtn.layer.masksToBounds = true
        
        inputDNI.layer.cornerRadius = 30
        inputDNI.layer.borderWidth = 2.0
        inputDNI.layer.borderColor = UIColor.lightGray.cgColor
        inputDNI.layer.masksToBounds = true
        
        segmentedControlContainerView.layer.cornerRadius = 38.0 // Adjust the value as needed
        segmentedControlContainerView.layer.masksToBounds = true
        
        stylizeSegmentedControlFonts()
    }
    
    
    func stylizeSegmentedControlFonts(){
        
        let customFont = UIFont(name: "Franie-Bold", size: 18)
        let fontAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: customFont,            NSAttributedString.Key.foregroundColor: UIColor.greyCAII
        ]
        segmentedControlDni.setTitleTextAttributes(fontAttributes, for: .normal)
        
        let fontAttributesDisabled: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: customFont,            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        segmentedControlDni.setTitleTextAttributes(fontAttributesDisabled, for: .selected)
        
    }
    
    
    
    @IBAction func onLoginPressed(_ sender: UIButton) {
        //TODO
//        if(inputDNI.text == "2"){
//            saveAuthenticatedUser(inputDNI.text! , "Fer2", "2")
//            goToMainStoryboard();
//            return
//        } else if(inputDNI.text == "1"){
//            saveAuthenticatedUser(inputDNI.text! , "Fer1", "1")
//            goToMainStoryboard();
//            return
//        }
        
        let apiService = APIService()
        apiService.login(inputDNI.text!, completion: { result in
            switch result {
            case .success(let data):
                // Handle the success case with the data
//                print("SuccessAGAGA: \(data)")
                self.saveAuthenticatedUser(data.dni_doc,String(data.nombres.components(separatedBy: " ").first ?? data.nombres) , String(data.modalidad_id))
                self.goToMainStoryboard();
                
            case .failure(let error):
                let message: String
                switch error {
                case .userError:
                    message = String(localized: "Credenciales invalidas")
                case .decodingError, .networkError:
                    message = String(localized: "Por favor contactese con el administrador: ") + error.localizedDescription
                }
                self.showAlert(message: message)
                
                //                 Handle the failure case with the error
                print("Error: \(error)")
            }
        })
    }
    
    
    func showAlert(message:String){
        let alert = UIAlertController(title: "Hey", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func saveAuthenticatedUser(_ dni: String,_ firstName: String,_ version:String) -> Void {
        defaults.set(dni, forKey: UDefaultValues.isLoggedIn.rawValue)
        defaults.set(firstName, forKey: UDefaultValues.firstName.rawValue)
        defaults.set(version, forKey: UDefaultValues.version.rawValue) // modalidad_id: 1 [PRESENCIAL], 2 [VIRTUAL]
        defaults.set(true, forKey: UDefaultValues.firstTimeHome.rawValue)
        defaults.set(true, forKey: UDefaultValues.firstTimeSchedule.rawValue)
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
    
    
//
//    func dispatchNotification(){
//        let title = "ola"
//        let body = "body1"
//    }
}
