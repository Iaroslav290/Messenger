//
//  AppViewController.swift
//  Messenger
//
//  Created by Ярослав Вербило on 2023-06-21.
//

import UIKit

let firstItem = UINavigationController(rootViewController: UsersViewController())
let secondItem = UINavigationController(rootViewController: MessageViewController())


class AppViewController: UITabBarController {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tabBar.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
       
        
        firstItem.tabBarItem = UITabBarItem(title: "Users", image: UIImage(systemName: "person.2"), tag: 0)
        firstItem.navigationBar.tintColor = #colorLiteral(red: 0.5613538623, green: 0, blue: 0.7421194911, alpha: 1)
        firstItem.navigationBar.barTintColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        
        // Create the second tab bar item
        
        secondItem.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(systemName: "message"), tag: 1)
        
        // Set the view controllers for the tab bar
        self.viewControllers = [firstItem, secondItem]
        
       

    }
}



