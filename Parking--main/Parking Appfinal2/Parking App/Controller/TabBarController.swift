//
//  TabBarController.swift
//  Parking App
//
//  Created by PC on 25/04/1443 AH.
//

import UIKit


class TabBarController: UITabBarController {
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: MainVC(), title: "", image: UIImage(systemName: "person")!),
            createNavController(for: UserProfileVC(), title: "", image: UIImage(systemName: "person")!),
            createNavController(for: MapVC(), title: "", image: UIImage(systemName: "calendar.circle")!)
        ]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
    }
}
