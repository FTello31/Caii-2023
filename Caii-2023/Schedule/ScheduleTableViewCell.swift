//
//  ScheduleTableViewCell.swift
//  Caii-2023
//
//  Created by Fernando Tello on 17/10/23.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    
    @IBOutlet weak var goTodetailBtn: UIButton!
    
    @IBOutlet weak var circleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        whiteView.layer.cornerRadius = 16
        // Configure the view for the selected state
        makeCircle()
        
        goTodetailBtn.layer.cornerRadius = min(goTodetailBtn.frame.size.height, goTodetailBtn.frame.size.width) / 2.0
        goTodetailBtn.layer.masksToBounds = true
        
    }
    
    func makeCircle(){
        circleView.layer.cornerRadius = min(circleView.frame.size.height, circleView.frame.size.width) / 2.0
        circleView.layer.borderColor = UIColor.black.cgColor
        circleView.backgroundColor = UIColor(named: "lightGreyCAII")
        circleView.layer.borderWidth = 1
    }
    
    
    
    
}
