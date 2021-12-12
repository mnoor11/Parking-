//
//  ReservationVC.swift
//  Parking App
//
//  Created by PC  on 20/04/1443 AH.
//
import UIKit
import Firebase

class ReservationVC: UIViewController {
    
    var locationName = String()
    var parkingsCount = Int()
    
    var reservesParkings = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setGradientBackground()
        
        view.addSubview(locationNameLabel)
        
        NSLayoutConstraint.activate([
            locationNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            locationNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            locationNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            locationNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        reservedParkingsCount { [self] in
            if reservesParkings < parkingsCount {
                view.addSubview(fieldsStackView)

                NSLayoutConstraint.activate([
                    fieldsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    fieldsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    fieldsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
                    fieldsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),

                    carNumberView.heightAnchor.constraint(equalToConstant: 50)
                ])
            } else {
                print("sorry, parkings full")
            }
        }
        
        
    }
    
    lazy var locationNameLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = locationName + " - \(parkingsCount)"
        $0.textAlignment = .right
        $0.font = UIFont.boldSystemFont(ofSize: 28)
        $0.textColor = .darkGray
        return $0
    }(UILabel())
    
    
    lazy var fieldsStackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 20
        return $0
    }(UIStackView(arrangedSubviews: [self.carNumberView, self.carTypeView, self.signupButton]))
    
    let carNumberView : CustomTextFieldView = {
        $0.textField.placeholder = NSLocalizedString("Car Number", comment: "")
        return $0
    }(CustomTextFieldView())
    
    let carTypeView : CustomTextFieldView = {
        $0.textField.placeholder = NSLocalizedString("Car Type", comment: "")
        return $0
    }(CustomTextFieldView())
   
    
    
    let signupButton : customButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(NSLocalizedString("Confirm", comment: ""), for: .normal)
        $0.addTarget(self, action: #selector(newReservationAction), for: .touchUpInside)
        return $0
    }(customButton(type: .system))
    
    
    var carNumberSuccess = false
    var carTypeSuccess = false
    
    @objc func newReservationAction() {
        
        if let carNumber = carNumberView.textField.text, carNumber.isEmpty == false {
            carNumberSuccess = true
            carNumberView.layer.shadowColor = UIColor.black.cgColor
        } else {
            // empty
            carNumberSuccess = false
            carNumberView.layer.shadowColor = UIColor.red.cgColor
        }
        
        if let carType = carTypeView.textField.text, carType.isEmpty == false {
            carTypeSuccess = true
            carTypeView.layer.shadowColor = UIColor.black.cgColor
        } else {
            // empty
            carTypeSuccess = false
            carTypeView.layer.shadowColor = UIColor.red.cgColor
        }
        
        if carNumberSuccess, carTypeSuccess {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
            let stringDate = dateFormatter.string(from: Date())
            
            guard let id = Auth.auth().currentUser?.uid else {return}

            Firestore.firestore().collection("Locations").document(id).setData([

                "carNumber" : carNumberView.textField.text!,
                "carType" : carTypeView.textField.text!,
                "time" : stringDate,
                "location" : locationName,

            ]) { error in
                if error == nil {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        
        

    }
    
    
    
    
    func reservedParkingsCount(completion : @escaping ()->()) {

        Firestore.firestore().collection("Locations").getDocuments { snapshot, error in
            
            if error == nil {
                if snapshot!.count > 0 {
                    for document in snapshot!.documents {
                        let data = document.data()
                        if data["location"] as? String == self.locationName {
                            self.reservesParkings += 1
                        }
                    }
                    completion()
                } else {
                    completion()
                }
            }
        }
    }


}
