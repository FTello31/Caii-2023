//
//  LoginAnimationViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 19/10/23.
//

import UIKit
import SwiftyGif


class LoginAnimationViewController: UIViewController {
    
    
    let logoAnimationView = LogoAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
    }
    
    
    let logoGifImageView: UIImageView = {
        guard let gifImage = try? UIImage(gifName: "Animación_CAII_sin_fondo.gif") else {
            return UIImageView()
        }
        return UIImageView(gifImage: gifImage, loopCount: 1)
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func presentLogin(){
        let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        
        present(vc, animated: true)
        
    }
    
}

extension LoginAnimationViewController: SwiftyGifDelegate {
    
    func gifURLDidFinish(sender: UIImageView) {
        print("gifURLDidFinish")
    }
    
    func gifURLDidFail(sender: UIImageView) {
        print("gifURLDidFail")
    }
    
    func gifDidStart(sender: UIImageView) {
//        print("gifDidStart", logoAnimationView.logoGifImageView.isAnimatingGif())
    }
    
    func gifDidLoop(sender: UIImageView) {
//        print("gifDidLoop", logoAnimationView.logoGifImageView.isAnimatingGif())
    }
    
    func gifDidStop(sender: UIImageView) {
//        print("gifDidStop", logoAnimationView.logoGifImageView.isAnimatingGif())
        presentLogin()
        
    }
    
}
