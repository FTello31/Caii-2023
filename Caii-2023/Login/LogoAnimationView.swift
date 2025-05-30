//
//  LogoAnimationView.swift
//  Caii-2023
//
//  Created by Fernando Tello on 14/10/23.
//

import UIKit
import SwiftyGif


class LogoAnimationView: UIView {

    let logoGifImageView: UIImageView = {
        guard let gifImage = try? UIImage(gifName: "Animación_CAII_sin_fondo.gif") else {
            return UIImageView()
        }
        return UIImageView(gifImage: gifImage, loopCount: 1)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        addSubview(logoGifImageView)
        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
        logoGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoGifImageView.widthAnchor.constraint(equalToConstant: 393).isActive = true
        logoGifImageView.heightAnchor.constraint(equalToConstant: 393).isActive = true
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
