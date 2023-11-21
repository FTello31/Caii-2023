//
//  TableViewCell.swift
//  Caii-2023
//
//  Created by Fernando Tello on 10/10/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var goToDetailBtn: UIButton!
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    var delegate: PonentesViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        contentViewGrey.backgroundColor = .lightGreyCAII
        containerView.layer.cornerRadius = 16
        goToDetailBtn.layer.cornerRadius = min(goToDetailBtn.frame.size.height, goToDetailBtn.frame.size.width) / 2.0
        goToDetailBtn.layer.masksToBounds = true
//        goToDetailBtn.clipsToBounds = true
        
        imageViewPhoto.layer.cornerRadius = min(imageViewPhoto.frame.size.height, imageViewPhoto.frame.size.width) / 2.0
    }
    
    
    
//    spacing to tableviewCell
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30))
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
//    @IBAction func goToDetailAction(_ sender: Any) {
//        print(sender)
//        delegate?.goToPonenteDetail(object: sender)
//
//    }
//    
    
}
