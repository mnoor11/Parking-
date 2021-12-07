//
//  MainVC.swift
//  Parking App
//
//  Created by PC  on 20/04/1443 AH.
//

import UIKit
import Firebase

class MainVC : UIViewController {
    
    var locationName = String()
    var parkings = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setGradientBackground()
        
        view.addSubview(titleLabel)
        view.addSubview(locationsStackView)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            locationsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            locationsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            locationsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            
            highCityButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        
        let myReservationButton = UIBarButtonItem(image : UIImage(systemName: "rectangle.trailinghalf.inset.filled.arrow.trailing"), style: .plain, target: self, action: #selector(reservationAction))
        myReservationButton.tintColor = .darkGray
        navigationItem.rightBarButtonItem = myReservationButton
        
        let signOutButton = UIBarButtonItem(image: UIImage(systemName: "power.circle"), style: .plain, target: self, action: #selector(signoutAction))
        signOutButton.tintColor = .red
        navigationItem.leftBarButtonItem = signOutButton
    }
    
    @objc func reservationAction() {
        self.navigationController?.pushViewController(MyReservationVC(), animated: true)
    }
    
    @objc func signoutAction() {
        try? Auth.auth().signOut()
        
        let vc = UINavigationController(rootViewController: SignInVC())
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    let titleLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = (NSLocalizedString("MyPark", comment: ""))
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.textAlignment = .center
        $0.textColor = .white
        return $0
    }(UILabel())
    
    lazy var locationsStackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 30
        return $0
    }(UIStackView(arrangedSubviews: [self.highCityButton, self.airportGarder, self.abhaViewButton]))
    
    
    let highCityButton : customButton = {
        $0.setTitle(NSLocalizedString("High City", comment: "") , for: .normal)
        $0.tag = 10
        $0.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return $0
    }(customButton(type: .system))
    
    
    let airportGarder : customButton = {
        $0.setTitle(NSLocalizedString("Airport Garden", comment: "") , for: .normal)
        $0.tag = 20
        $0.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return $0
    }(customButton(type: .system))
    
    
    let abhaViewButton : customButton = {
        
        $0.tag = 30
        $0.setTitle(NSLocalizedString("Abha View", comment: "") , for: .normal)
        $0.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return $0
    }(customButton(type: .system))
    
    
    @objc func buttonAction(_ sender : UIButton) {
        if sender.tag == 10 {
            parkings = 1
            locationName = "High City"
        }
        else if sender.tag == 20 {
            parkings = 230
            locationName = "Airport Garder"
        }
        else {
            parkings = 80
            locationName = "Abha View"
        }
        
        
        let vc = ReservationVC()
        vc.parkingsCount = parkings
        vc.locationName = locationName
        vc.locationNameArabic = (sender.titleLabel?.text)!
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
