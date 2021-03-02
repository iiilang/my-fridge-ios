//
//  TabBarController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/02/11.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor.refridgeColor(color: .blue)
        self.tabBar.unselectedItemTintColor = UIColor.refridgeColor(color: .gray)
        self.tabBar.isTranslucent = false

        setUpTabBar()
    }
    
    /*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let tabBarHeight: CGFloat = 75
        var tabFrame = tabBar.frame
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        tabBar.frame = tabFrame
    } */
    
    private func setUpTabBar() {
        let refridgeViewController = ViewController()
        refridgeViewController.tabBarItem.image = UIImage(named: "tabFridge")
        //refridgeViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        
        let shoppingViewController = ShoppingViewController()
        shoppingViewController.tabBarItem.image = UIImage(named: "tabShop")
        //shoppingViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 13.5, left: 0, bottom: -13.5, right: 0)
        
        viewControllers = [refridgeViewController, shoppingViewController]
    }
    
}
