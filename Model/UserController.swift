//
//  UserController.swift
//  MyFavoriteApp
//
//  Created by Colin Smith on 3/20/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import Foundation


class UserController {
    
    //Shared Instance
    
    static var shared = UserController()
    private init() {}
    
    //Source of Truth
    var arrayOfUsers: [User] = []
    
    //Base URL
    
     let baseURL = URL(string: "https://favoriteapp-375c6.firebaseio.com")
    
    //MARK: - CRUD Function
    
    
    
    //Get Request (Read)
    
   func getUsers(completion: @escaping (Bool) -> Void){
        
        guard let url = baseURL else { completion(false); return}
        url.appendingPathComponent("users")
        url.appendingPathExtension("json")
        print(url)
        
        var request =  URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
        //                              vvvDEFINING VARIABLES FOR THE COMING CLOSUREvvvv
        //                                       vvvvv     vvvvv       vvvv
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("there was an \(error) retrieving the data. \(error.localizedDescription)")
                
            }
            if let response = response{
                print(response)
            }
            guard let data = data else {completion(false) ; return}
                let decoder = JSONDecoder()
            do{
                let dictionaryOfUsers = try decoder.decode([String : User ].self, from: data)
                //temporary place to store array values
                var tempUsers: [User] = []
                for (_, value) in dictionaryOfUsers{
                    tempUsers.append(value)
                }
                self.arrayOfUsers = tempUsers
                //tell calling function that "we did it" We got users
                completion(true)
            }catch{
                print("could not load from dictionary \(error.localizedDescription)")
                completion(false)
            }
            
        }.resume()
    }
    
    
    //Post Request (Create)
    func postUser(name: String, favoriteApp: String, completion: @escaping (Bool) -> Void) {
            //URL
        guard var url = baseURL else {return}
        url.appendPathExtension("user")
        url.appendingPathComponent("json")
        print(url)
        
        //request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let newUser = User(user: name, favoriteApp: favoriteApp )
        
        let encoder = JSONEncoder()
        
        do{
           let data = try encoder.encode(newUser)
        }catch{
            print("There was an error encoding to JSON \(error.localizedDescription)")
        }
        
        
        
        //DataTask & Resume
        let dataTask = URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error{
                print("There was an error POSTint the data: \(error.localizedDescription)")
                completion(false)
            }
            self.arrayOfUsers.append(newUser)
            completion(true)
        }
        dataTask.resume()
    }
    
}
