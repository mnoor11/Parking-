//
//  Extensions.swift
//  Parking App
//
//  Created by PC  on 21/04/1443 AH.
//

import UIKit

extension UIViewController {
    
    func setGradientBackground() {
        
        view.backgroundColor = .white
        
        let colorTop = UIColor(red: 0.02, green: 0.22, blue: 0.31, alpha: 0.3).cgColor
        let colorBottom = UIColor(red: 0.02, green: 0.22, blue: 0.31, alpha: 1.0).cgColor
        //UIColor(red: 1.00, green: 0.93, blue: 0.88, alpha: 1.00).cgColor
        
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
}


class customButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        tintColor = .init(white: 0.95, alpha: 1)
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1
        
    }
    
    override func setNeedsLayout() {
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        layer.cornerRadius = frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
