//
//  CustomTextFieldView.swift
//  Parking App
//
//  Created by PC on 20/04/1443 AH.
//

import UIKit

class CustomTextFieldView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 25
        backgroundColor = .init(white: 0.95, alpha: 0.8) //UIColor(red: 0.99, green: 0.95, blue: 0.91, alpha: 1.00)

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        
        self.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
        ])
    }
    
    let textField : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .darkGray
        $0.backgroundColor = .clear
        $0.textColor = .darkGray
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.attributedPlaceholder = NSAttributedString(
            string: "Placeholder Text",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)])
        return $0
    }(UITextField())
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

