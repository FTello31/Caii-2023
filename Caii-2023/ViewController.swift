//
//  ViewController.swift
//  Caii-2023
//
//  Created by Fernando Tello on 7/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputDNI: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func onLoginPressed(_ sender: UIButton) {
        
        if(inputDNI.text == "1"){
            print("holas")
            // go to next storyboard
        }else{
            let alert = UIAlertController(title: "Hey", message: "This is  one Alert", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Working!!", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

