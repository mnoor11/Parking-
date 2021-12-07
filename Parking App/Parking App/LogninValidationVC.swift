//
//  LogninValidationVC.swift
//  Parking App
//
//  Created by PC  on 23/04/1443 AH.
//

import UIKit
import Firebase

class LogninValidationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white

        setGradientBackground()
        
        if Auth.auth().currentUser?.uid != nil {
            // go to MainVC
            let vc = UINavigationController(rootViewController: TabBarController())
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(vc, animated: true, completion: nil)
            }
            
        }
        else {
            // go to SignInVC
            let vc = UINavigationController(rootViewController: SignInVC())
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    

    

}
