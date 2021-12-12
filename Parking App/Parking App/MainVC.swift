//
//  MainVC.swift
//  Parking App
//
//  Created by PC  on 20/04/1443 AH.
//
import UIKit
import Firebase

class MainVC : UIViewController {
    
    let locations = ["High City", "Airport Garden", "Abha View"]
    
    var locationName = String()
    var parkings = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setGradientBackground()
        
        view.addSubview(titleLabel)
        view.addSubview(locationTableView)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            locationTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
            locationTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            locationTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            locationTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            
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
        let alert1 = UIAlertController(
            title: (NSLocalizedString("There is no ‼️", comment: "")),message: NSLocalizedString("No parking found ", comment: ""),preferredStyle: .alert)
        alert1.addAction(UIAlertAction(title: "OK",style: .default,handler: { action in
            print("OK")
        }
                                      )
       )
        present(alert1, animated: true, completion: nil)
        
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
        $0.text = NSLocalizedString("My Parking", comment: "")
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.textAlignment = .center
        $0.textColor = .darkGray
        return $0
    }(UILabel())
    
    lazy var locationTableView : UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(LocationCell.self, forCellReuseIdentifier: "Cell")
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        return $0
    }(UITableView())
    
}


extension MainVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LocationCell
        cell.locationLabel.text = NSLocalizedString(locations[indexPath.row], comment: "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            parkings = 300
        }
        else if indexPath.row == 1 {
            parkings = 230
        }
        else {
            parkings = 80
        }
        
        let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) as! LocationCell
        
        let vc = ReservationVC()
        vc.parkingsCount = parkings
        vc.locationName = cell.locationLabel.text!
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
