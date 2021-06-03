//
//  TabBarController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/02/11.
//

import UIKit

class TabBarController: UITabBarController {
    
    //var foods = [Food]()
    var model = FoodModel()
    
    let tabBarHeight: CGFloat = 75
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.ping()
        //model.getFoods()
    }
    
    /*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let tabBarHeight: CGFloat = self.tabBarHeight
        var tabFrame = tabBar.frame
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        tabBar.frame = tabFrame
        
    }*/
    
    private func setUpTabBar() {
        
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor.refridgeColor(color: .blue)
        self.tabBar.unselectedItemTintColor = UIColor.refridgeColor(color: .gray)
        self.tabBar.isTranslucent = false
        
        let refridgeViewController = UINavigationController(rootViewController: FridgeViewController())
        refridgeViewController.navigationBar.isHidden = true
            
        refridgeViewController.tabBarItem.image = UIImage(named: "tabFridge")
        refridgeViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
        
        let shoppingViewController = ShoppingViewController()
        shoppingViewController.tabBarItem.image = UIImage(named: "tabShop")
        shoppingViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        self.viewControllers = [refridgeViewController, shoppingViewController]
    }
}

extension TabBarController: FoodModelProtocol {
    func foodsRetrieved(foods: [Food]) {
        print("foods retrieved from food model!")
        //self.foods = foods
    }
}
