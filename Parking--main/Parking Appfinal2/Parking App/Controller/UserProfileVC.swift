//
//  UserProfileVC.swift
//  Parking App
//
//  Created by PC on 12/06/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class UserProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(fieldsStackView)
        setGradientBackground()
        
        NSLayoutConstraint.activate([
            fieldsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fieldsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fieldsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80),
            
            .heightAnchor.constraint(equalToConstant: 40)
        ])
        
        getUserData()
    }
    
    func getUserData() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("Users").document(uid).getDocument(completion: { snapshot, error in
            if let value = snapshot?.data() {
                if let name = value["name"] as? String, let email = value["email"] as? String {
                    self.nameLable.text = name
                    self.emailLable.text = email
                }
            }
                
            
        })
    }
    

    lazy var fieldsStackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 20
        return $0
    }(UIStackView(arrangedSubviews: [self.nameLable, self.emailLable, self.signOutButton]))
    
    let image : UIImageView = {
        $0.tintColor = .darkGray
        $0.image = UIImage(systemName: "person.circle.fill")
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        
      return $0
    }(UIImageView())
  
    let nameLable : UILabel = {
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textAlignment = .center
        $0.text = "Name"
        return $0
    }(UILabel())

    let emailLable : UILabel = {
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textAlignment = .center
        $0.text = "Email"
        return $0
    }(UILabel())
    
    let signOutButton : UIButton = {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        $0.backgroundColor = .red
        $0.setTitle("Sign Out", for: .normal)
        $0.addTarget(self, action: #selector(signoutAction), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    @objc func signoutAction() {
        try? Auth.auth().signOut()
        
        let vc = UINavigationController(rootViewController: SignInVC())
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
