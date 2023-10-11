//
//  FilterViewCell.swift
//  CollectionViewDynamicSizing
//
//  Created by Shankar on 13/03/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit

class FilterViewCell: UICollectionViewCell {
   
    @IBOutlet weak var labelFilterName: UILabel!
    @IBOutlet weak var viewFilter: UIView!
    
    override func awakeFromNib() {
        viewFilter.addPurpleBorderAndCorner()
    }
}

extension UIView {
    func addPurpleBorderAndCorner() {
        layer.cornerRadius = 8
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.5
    }
}
