//
//  MyReservationVC.swift
//  Parking App
//
//  Created by PC on 22/04/1443 AH.
//

import UIKit
import Firebase


class MyReservationVC: UIViewController {

    var enteingDateString = String()
    var exitDateString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setGradientBackground()
        getParkingDetails()
    }
    
    
    let containerView : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .init(white: 0.95, alpha: 0.8)
        $0.layer.cornerRadius = 10
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowOffset = CGSize.zero
        $0.layer.shadowRadius = 5
        return $0
    }(UIView())
    
    
    lazy var labelsStackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [self.carNumberLebel, self.carTypeLabel, self.dateLebel]))

    
    let locationNameLebel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.boldSystemFont(ofSize: 25)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    let carNumberLebel : UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
//        $0.textAlignment = .right
        $0.textColor = .darkGray
        return $0
    }(UILabel())

    let carTypeLabel : UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
//        $0.textAlignment = .right
        $0.textColor = .darkGray
        return $0
    }(UILabel())
    
    let dateLebel : UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
//        $0.textAlignment = .right
        $0.textColor = .darkGray
        return $0
    }(UILabel())
    
    let parkingExitButton : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(NSLocalizedString("Exit", comment: ""), for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        $0.layer.cornerRadius = 25
        $0.addTarget(self, action: #selector(prkingExitAction), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    @objc func prkingExitAction() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        
        exitDateString = dateFormatter.string(from: Date())
       
        let enteringDate = dateFormatter.date(from: enteingDateString)
        let exitDate = dateFormatter.date(from: exitDateString)
        
        let diff = Calendar.current.dateComponents([.hour, .minute], from: enteringDate!, to: exitDate!)
        
        guard var durationHours = diff.hour else {return}
        
        durationHours += 1
        
        durationLabel.text = "\(durationHours) " + NSLocalizedString("Hours", comment: "")
        
        
        let hourPrice = 20
        let totalPrice = durationHours * hourPrice
        
        priceLabel.text = "\(totalPrice) " + NSLocalizedString("SR", comment: "")
        
        guard let id = Auth.auth().currentUser?.uid else {return}
        
        Firestore.firestore().collection("Locations").document(id).delete { [self] error in
            if error == nil {
                containerView.addSubview(barcodeImageView)
                containerView.addSubview(priceStackView)
                containerView.addSubview(enteringAndExitStackView)
                
                enteringDateLabel.text = NSLocalizedString("Enter", comment: "") + " : \(enteingDateString)"
                exitDateLabel.text = NSLocalizedString("Exit", comment: "") + " : \(exitDateString)"
                
                NSLayoutConstraint.activate([
                    barcodeImageView.topAnchor.constraint(equalTo: locationNameLebel.bottomAnchor, constant: 20),
                    barcodeImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                    barcodeImageView.widthAnchor.constraint(equalToConstant: 100),
                    barcodeImageView.heightAnchor.constraint(equalTo: barcodeImageView.widthAnchor),
                    
                    priceStackView.topAnchor.constraint(equalTo: barcodeImageView.bottomAnchor, constant: 10),
                    priceStackView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
                    priceStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
                    
                    enteringAndExitStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 25),
                    enteringAndExitStackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
                    enteringAndExitStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
                    enteringAndExitStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -25)
                ])
                
                labelsStackView.removeFromSuperview()
                parkingExitButton.removeFromSuperview()
            }
        }
    }
    
    let barcodeImageView : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "barcode-png")
        $0.contentMode = .scaleAspectFill
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        return $0
    }(UIImageView())
    
    lazy var priceStackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [self.durationLabel, self.priceLabel]))
    
    let durationLabel : UILabel = {
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    let priceLabel : UILabel = {
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    lazy var enteringAndExitStackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [self.enteringDateLabel, self.exitDateLabel]))
    
    let enteringDateLabel : UILabel = {
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .darkGray
        return $0
    }(UILabel())
    
    let exitDateLabel : UILabel = {
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .darkGray
        return $0
    }(UILabel())
    
    
    func getParkingDetails() {
        guard let id = Auth.auth().currentUser?.uid else{return}
        
        Firestore.firestore().collection("Locations").document(id).getDocument { [self] snapshot, error in
            if error == nil {
                if let data = snapshot?.data() {
                    
                    
                    view.addSubview(containerView)
                    containerView.addSubview(locationNameLebel)
                    containerView.addSubview(labelsStackView)
                    view.addSubview(parkingExitButton)
                    
                    
                    
                    NSLayoutConstraint.activate([
                        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
                        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
                        containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
                        
                        locationNameLebel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 25),
                        locationNameLebel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
                        locationNameLebel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
                        locationNameLebel.heightAnchor.constraint(equalToConstant: 35),
                        
                        labelsStackView.topAnchor.constraint(equalTo: locationNameLebel.bottomAnchor, constant: 10),
                        labelsStackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
                        labelsStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
                        labelsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -25),
                        
                        carNumberLebel.heightAnchor.constraint(equalToConstant: 30),
                        
                        parkingExitButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
                        parkingExitButton.widthAnchor.constraint(equalTo: containerView.widthAnchor),
                        parkingExitButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                        parkingExitButton.heightAnchor.constraint(equalToConstant: 50),
                        
                    ])
                    
                    
                    self.carNumberLebel.text = NSLocalizedString("Car Number", comment: "") + " : \(data["carNumber"] as! String)"
                    self.carTypeLabel.text = NSLocalizedString("Car Type" , comment: "") + " : \(data["carType"] as! String)"
                    self.dateLebel.text = NSLocalizedString("Date", comment: "") + " : \(data["time"] as! String)"
                    self.locationNameLebel.text = data["location"] as? String
                    self.enteingDateString = (data["time"] as? String)!
                } else {
                    
                    let noReservationLabel = UILabel()
                    noReservationLabel.frame = view.bounds
                    noReservationLabel.text = NSLocalizedString("No Parkings Found", comment: "")
                    noReservationLabel.textAlignment = .center
                    noReservationLabel.font = UIFont.boldSystemFont(ofSize: 18)
                    noReservationLabel.textColor = .init(white: 0.95, alpha: 0.8)
                    
                    view.addSubview(noReservationLabel)
                    
                    self.showAlert(title: "", message: "No Parkings Found")
                }
                    
                

            }
        }
    }
    
    
}
