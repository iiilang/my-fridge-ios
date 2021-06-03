//
//  FoodModel.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/04/14.
//

import Foundation
import Alamofire

protocol FoodModelProtocol {
    func foodsRetrieved(foods: [Food])
}

class FoodModel {
    
    var delegate: FoodModelProtocol?
    
    func ping() {
        AF.request("http://ec2-3-34-204-152.ap-northeast-2.compute.amazonaws.com:8080/ping").responseString { response in
            switch response.result {
            case .success:
                print(try! response.result.get())
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func pingURLSession() {
        let urlString = "http://ec2-3-34-204-152.ap-northeast-2.compute.amazonaws.com:8080/ping"
        let url = URL(string: urlString)

        guard url != nil else {
            print("Can't create url object")
            return
        }

        let session = URLSession.shared

        let datatask = session.dataTask(with: url!) { (data, response, error) in

            if error == nil && data != nil {
                let pong = String(decoding: data!, as: UTF8.self)
                print(pong)
            }
        }
        datatask.resume()
    }
    
    func getFoods() {
        
//        let urlString = "http://ec2-3-34-204-152.ap-northeast-2.compute.amazonaws.com:8080/api/v1/food/"
//        let url = URL(string: urlString)
//
//        guard url != nil else {
//            print("Can't create url object")
//            return
//        }
//
//        let session = URLSession.shared
//
//        let datatask = session.dataTask(with: url!) { (data, response, error) in
//
//            let decoder = JSONDecoder()
//
//            if error == nil && data != nil {
//                do {
//                    let food = try decoder.decode([Food].self, from: data!)
//                    DispatchQueue.main.async {
//                        self.delegate?.foodsRetrieved(foods: FoodService.foods!)
//                    }
//                } catch {
//                    print("error parsing the json")
//                }
//            }
//        }
//        datatask.resume()
        
    }
}
