//
//  TableViewCell.swift
//  Caii-2023
//
//  Created by Fernando Tello on 10/10/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var goToDetailButton: UIButton!
    
    var delegate: PonentesViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("a")
        // Initialization code
    }

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
