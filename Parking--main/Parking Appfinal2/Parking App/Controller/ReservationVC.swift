//
import UIKit
import Firebase

class ReservationVC: UIViewController {
    
    var locationName = String()
    var parkingsCount = Int()
    var locationIndex = 0
    var selectedLocation = String()
    
    var locationImages = [UIImage]()
    
    var layout = UICollectionViewFlowLayout()
    
    var reservesParkings = 0
    
    var timer = Timer()
    var animationIndex = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
        
        switch locationIndex {
        case 0 :
            selectedLocation = "HighCity"
        case 1 :
            selectedLocation = "AirportGarden"
        default:
            selectedLocation = "AbhaView"
        }
        
        for i in 1...2 {
            locationImages.append(UIImage(named: "\(selectedLocation)\(i)")!)
        }
        LocationCollectionView.reloadData()
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(imagesAnimation), userInfo: nil, repeats: true)

        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 50 , height: 150)
        layout.scrollDirection = .horizontal
        
        view.backgroundColor = .white
        setGradientBackground()
        
        view.addSubview(locationNameLabel)
        view.addSubview(collectionContainerView)
        collectionContainerView.addSubview(LocationCollectionView)
        
        NSLayoutConstraint.activate([
            locationNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            locationNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            locationNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            locationNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            collectionContainerView.topAnchor.constraint(equalTo: locationNameLabel.bottomAnchor, constant: 30),
            collectionContainerView.widthAnchor.constraint(equalTo: locationNameLabel.widthAnchor),
            collectionContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionContainerView.heightAnchor.constraint(equalToConstant: 150),
            
            LocationCollectionView.topAnchor.constraint(equalTo: collectionContainerView.topAnchor),
            LocationCollectionView.bottomAnchor.constraint(equalTo: collectionContainerView.bottomAnchor),
            LocationCollectionView.rightAnchor.constraint(equalTo: collectionContainerView.rightAnchor),
            LocationCollectionView.leftAnchor.constraint(equalTo: collectionContainerView.leftAnchor),
        ])
        
        
        reservedParkingsCount { [self] in
            if reservesParkings < parkingsCount {
                view.addSubview(fieldsStackView)

                NSLayoutConstraint.activate([
                    fieldsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    fieldsStackView.topAnchor.constraint(equalTo: LocationCollectionView.bottomAnchor, constant: 30),
                    fieldsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
                    fieldsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),

                    carNumberView.heightAnchor.constraint(equalToConstant: 50)
                ])
            } else {
                self.showAlert(title: "", message: "sorry, parkings full")
            }
        }
        
        
    }
    
    @objc func imagesAnimation() {
        self.LocationCollectionView.scrollToItem(at: IndexPath(item: self.animationIndex, section: 0), at: .top, animated: true)
        
        if animationIndex == 1 {
            animationIndex = 0
        } else {
            animationIndex = 1
        }
    }
    
    lazy var locationNameLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = locationName + " - \(parkingsCount)"
        $0.textAlignment = .right
        $0.font = UIFont.boldSystemFont(ofSize: 28)
        $0.textColor = Colors.titles
        return $0
    }(UILabel())
    
    let collectionContainerView : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    lazy var LocationCollectionView : UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.isUserInteractionEnabled = true
        $0.delegate = self
        $0.dataSource = self
        $0.register(LocationImageCell.self, forCellWithReuseIdentifier: "Cell")
        return $0
    }(UICollectionView(frame: self.collectionContainerView.frame, collectionViewLayout: layout))
    
    
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

extension ReservationVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = LocationCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LocationImageCell
//        cell.backgroundColor = UIColor.orange
        cell.locationImage.image = locationImages[indexPath.row]
        return cell
    }
   
}


extension ReservationVC {
    @objc func labelTapped(_ sender : UITapGestureRecognizer) {
       let locationTapped = sender.location(in: view)
       let tapAnimationView = UIView(frame: CGRect(x: locationTapped.x, y: locationTapped.y, width: 30, height: 30))
       tapAnimationView.layer.cornerRadius = 15
       tapAnimationView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
       tapAnimationView.transform = CGAffineTransform(scaleX: 0, y: 0)
       view.addSubview(tapAnimationView)
       
       UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
           tapAnimationView.transform = CGAffineTransform.identity
       }
       
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
           tapAnimationView.removeFromSuperview()
       }
   }
}
