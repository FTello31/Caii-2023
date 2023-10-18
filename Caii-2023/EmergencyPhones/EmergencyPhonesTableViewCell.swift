//
//  EmergencyPhonesTableViewCell.swift
//  Caii-2023
//
//  Created by Fernando Tello on 11/10/23.
//

import UIKit

class EmergencyPhonesTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var callBtn: UIButton!
    
    
    //create your closure here
    var buttonPressed : (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        whiteView.layer.cornerRadius = 16
        
        callBtn.layer.cornerRadius = 20
        callBtn.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func callNumber(_ sender: Any) {
        //https://stackoverflow.com/questions/39947076/uitableviewcell-buttons-with-action
        buttonPressed()
    }
}
