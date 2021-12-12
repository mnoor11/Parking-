//
//  LocationCell.swift
//  Parking App
//
//  Created by PC on 08/05/1443 AH.
//


import UIKit

class LocationCell : UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            locationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            locationLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            locationLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            locationLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    let locationLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 25)
        $0.layer.cornerRadius = 35
        $0.layer.masksToBounds = true
        $0.textColor = .white
        $0.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        $0.tintColor = .init(white: 0.95, alpha: 1)
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.layer.borderWidth = 1
        return $0
    }(UILabel())
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
