//
//  LocationImageCell.swift
//  Parking App
//
//  Created by PC on 08/05/1443 AH.
//

import UIKit

class LocationImageCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(locationImage)
    }
    
    lazy var locationImage : UIImageView = {
        $0.frame = self.bounds
        $0.contentMode = .scaleToFill
        return $0
    }(UIImageView())
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
