//
//  HomeButtonCollectionViewCell.swift
//  Caii-2023
//
//  Created by Fernando Tello on 16/10/23.
//

import UIKit

class HomeButtonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var backgroundIcon: UIView!
    @IBOutlet weak var icon: UIImageView!
    //
    override func awakeFromNib() {
        self.contentView.isUserInteractionEnabled = false // make the button be tappable
    }
    
}
