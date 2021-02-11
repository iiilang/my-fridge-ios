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
        
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor.refridgeColor(color: .blue)
        tabBar.unselectedItemTintColor = UIColor.refridgeColor(color: .gray)

        setUpTabBar()
    }
    
    
    private func setUpTabBar() {
        
        let refridgeViewController = ViewController()
        refridgeViewController.tabBarItem.image = UIImage(named: "tabFridge")
        refridgeViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        
        let shoppingViewController = ShoppingViewController()
        shoppingViewController.tabBarItem.image = UIImage(named: "tabShop")
        shoppingViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 13.5, left: 0, bottom: -13.5, right: 0)
        
        
        viewControllers = [refridgeViewController, shoppingViewController]
    }
}
/*
extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 75
        return sizeThatFits
    }
}*/
