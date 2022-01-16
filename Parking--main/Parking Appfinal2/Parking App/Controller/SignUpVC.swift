//
//  SignUpVC.swift
//  Parking App
//
//  Created by PC on 20/04/1443 AH.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setGradientBackground()
   
    }
    
    
    lazy var profileImage : UIImageView = {
        $0.tintColor = .darkGray
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "person.circle.fill")
        $0.layer.cornerRadius = 50
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
 
    
    lazy var fieldsStackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 20
        return $0
    }(UIStackView(arrangedSubviews: [self.nameView, self.emailView, self.passwordView, self.signupButton]))
    
    let nameView : CustomTextFieldView = {
        $0.textField.placeholder = NSLocalizedString("name", comment: "")
        return $0
    }(CustomTextFieldView())
    
    let emailView : CustomTextFieldView = {
        $0.textField.placeholder = NSLocalizedString("email", comment: "")
        return $0
    }(CustomTextFieldView())
    
    let passwordView : CustomTextFieldView = {
        $0.textField.placeholder = NSLocalizedString("password", comment: "")
        $0.textField.isSecureTextEntry = true
        return $0
    }(CustomTextFieldView())
    
    
    let signupButton : customButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(NSLocalizedString("Sign Up", comment: ""), for: .normal)
        $0.addTarget(self, action: #selector(signupAction), for: .touchUpInside)
        return $0
    }(customButton(type: .system))

    
    var nameSuccess = false
    var emailSuccess = false
    var passwordSuccess = false
    
    @objc func signupAction() {
        if let name = nameView.textField.text, name.isEmpty == false {
            nameSuccess = true
            nameView.layer.shadowColor = UIColor.black.cgColor
        } else {
            // empty
            nameSuccess = false
            nameView.layer.shadowColor = UIColor.red.cgColor
        }
        
        if let email = emailView.textField.text, email.isEmpty == false {
            emailSuccess = true
            emailView.layer.shadowColor = UIColor.black.cgColor
        } else {
            // empty
            emailSuccess = false
            emailView.layer.shadowColor = UIColor.red.cgColor
        }
        
        if let password = passwordView.textField.text, password.isEmpty == false {
            passwordSuccess = true
            passwordView.layer.shadowColor = UIColor.black.cgColor
        } else {
            // empty
            passwordSuccess = false
            passwordView.layer.shadowColor = UIColor.red.cgColor
        }
        
        
        if nameSuccess, emailSuccess, passwordSuccess {
            // firebase signup
            Auth.auth().createUser(withEmail: emailView.textField.text!, password: passwordView.textField.text!) { result, error in
                if error == nil {
                    guard let userID = result?.user.uid else {return}
                    
                    Firestore.firestore().collection("Users").document(userID).setData([
                        "name" : self.nameView.textField.text!,
                        "email" : self.emailView.textField.text!,
                        "id" : userID,
                    ]) { error in
                        if error == nil {
                            print("Done")
                            DispatchQueue.main.async {
                                let vc = UINavigationController(rootViewController: TabBarController())
                                vc.modalTransitionStyle = .crossDissolve
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true, completion: nil)
                            }
                        }
                    }
                } else {
                    // show error message
                    self.showAlert(title: "Error", message: "Unkown Error")
                }
            }
        }
    }


}

extension SignUpVC {
    func setupUI() {
        
        view.addSubview(profileImage)
        view.addSubview(fieldsStackView)
        
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor),
            
            
            fieldsStackView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 60),
            fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            emailView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}
