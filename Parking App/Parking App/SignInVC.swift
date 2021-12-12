//
//  SignInVC.swift
//  Parking App
//
//  Created by PC on 20/04/1443 AH.
//


import UIKit
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    let logoImage : UIImageView = {
        $0.tintColor = .darkGray
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "person.circle.fill")
        return $0
    }(UIImageView())
    
    let appNameLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = NSLocalizedString("My Parking", comment: "")
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.textColor = .init(white: 0.95, alpha: 0.8)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    lazy var fieldsStackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 18
        return $0
    }(UIStackView(arrangedSubviews: [self.emailView, self.passwordView, self.signInButton, self.signupButton]))
    
    let emailView : CustomTextFieldView = {
        $0.textField.placeholder = NSLocalizedString("email", comment: "")
        return $0
    }(CustomTextFieldView())
    
    let passwordView : CustomTextFieldView = {
        $0.textField.placeholder = NSLocalizedString("password", comment: "")
        $0.textField.isSecureTextEntry = true
        return $0
    }(CustomTextFieldView())
    
    
    let signInButton : customButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(NSLocalizedString("Sign In", comment: ""), for: .normal)
        $0.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        return $0
    }(customButton(type: .system))
    
    var emailSuccess = false
    var passwordSuccess = false
    
    @objc func signInButtonAction() {
        
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
        
        Auth.auth().signIn(withEmail: emailView.textField.text!, password: passwordView.textField.text!) { result, error in
            if error == nil {
                let vc = UINavigationController(rootViewController: TabBarController())
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            else {
                // show error message
            }
        }
    }

    
    let signupButton : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(NSLocalizedString("Don't have an account ? Sign UP", comment: ""), for: .normal)
        $0.layer.cornerRadius = 20
        $0.tintColor = .init(white: 0.95, alpha: 0.8)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.addTarget(self, action: #selector(showSignupVC), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))

    @objc func showSignupVC() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(SignUpVC(), animated: true)
    }

}

extension SignInVC {
    func setupUI() {
        setGradientBackground()
        
        view.addSubview(logoImage)
        view.addSubview(appNameLabel)
        view.addSubview(fieldsStackView)
        
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalTo: logoImage.heightAnchor),
            
            appNameLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20),
            appNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            appNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            
            fieldsStackView.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 60),
            fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            emailView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    
    
}



