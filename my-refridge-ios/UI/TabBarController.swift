//
//  TabBarController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/02/11.
//

import UIKit
import Alamofire

let url = "http://ec2-3-34-204-152.ap-northeast-2.compute.amazonaws.com:8080"
var userId: Int?

class TabBarController: UITabBarController {

    
    let tabBarHeight: CGFloat = 75
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpTabBar()
        
        //print(UIDevice.current.identifierForVendor?.uuidString)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //처음 실행 시 userId 받아와서 저장.
        let isFirstLaunch = Storage.isFirstLaunch()
        if isFirstLaunch {
            saveUser { id in
                if id != nil {
                    let defaults = UserDefaults.standard
                    defaults.set(id, forKey: "userId")
                    
                    userId = id
                }
            }
        } else {
            let userIdAny = UserDefaults.standard.object(forKey: "userId") as! Int
            userId = userIdAny
        }
    }
    
    func saveUser(handler: @escaping (Int) -> Void) {
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        let urlString = url + "/api/v1/users"
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let param: Parameters = [
            "uuid" : uuid
        ]
        
        
        AF.request(
            urlString,
            method: .post,
            parameters: param,
            encoding: JSONEncoding.default,
            headers: header
        )
        .responseJSON { response in
            switch response.result {
            case .success:
                guard let result = response.data else { return }
                print( String(decoding: result, as: UTF8.self) )
                
                if response.response?.statusCode == 200 {
                    let decoder = JSONDecoder()
                    
                    let userInfo = try! decoder.decode(UserInfo.self, from: result)
                    handler(userInfo.id)
                }
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
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
