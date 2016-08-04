//
//  GithubAPIClient.swift
//  swift-githubRepoSearch-lab
//
//  Created by Haaris Muneer on 7/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GithubAPIClient {
    
    class func getRepositoriesWithCompletion(completion: (NSArray) -> ()) {
        
        Alamofire.request(.GET, "\(Secrets.APIURL)/repositories?client_id=\(Secrets.clientID)&client_secret=\(Secrets.clientSecret)")
            .responseJSON { response in
                
                if let json = response.result.value {
                    let repoArray = json as! NSArray
                    completion(repoArray)
                    //print(repoArray)
                }
        }
    }
    
    
    //    class func getRepositoriesWithCompletion(completion: (NSArray) -> ()) {
    //        let urlString = "\(Secrets.APIURL)/repositories?client_id=\(Secrets.clientID)&client_secret=\(Secrets.clientSecret)"
    //        let url = NSURL(string: urlString)
    //        let session = NSURLSession.sharedSession()
    //
    //        guard let unwrappedURL = url else { fatalError("Invalid URL") }
    //        let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
    //            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
    //
    //            if let responseArray = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSArray {
    //                if let responseArray = responseArray {
    //                    completion(responseArray)
    //                }
    //            }
    //        }
    //        task.resume()
    //    }
    
    class func checkIfRepositoryIsStarred(fullName: String, completion:(Bool) -> ()) {
        
        Alamofire.request(.GET, "\(Secrets.starApiUrl)/\(fullName)", encoding: .JSON, headers: ["Authorization" : "\(Secrets.token)"])
            .responseJSON { response in
                
                if let responseValue = response.response {
                    
                    if responseValue.statusCode == 204 {
                        print("was starred")
                        completion(true)
                        
                    } else if responseValue.statusCode == 404 {
                         print("was unstarred")
                        completion(false)
                        
                       
                        
                    }
                }
        }
    }
    
    
    
    
    //    class func checkIfRepositoryIsStarred(fullName: String, completion:(Bool) -> ()) {
    //        let urlString = "\(Secrets.starApiUrl)/\(fullName)"
    //        let url = NSURL(string: urlString)
    //        let session = NSURLSession.sharedSession()
    //        guard let unwrappedURL = url else { fatalError("Invalid URL") }
    //
    //        let request = NSMutableURLRequest(URL: unwrappedURL)
    //        request.HTTPMethod = "GET"
    //        request.addValue("\(Secrets.token)", forHTTPHeaderField: "Autorisation")
    //        let task = session.dataTaskWithRequest(request) { (data, response, error) in
    //            guard let responseValue = response as? NSHTTPURLResponse else {
    //                assertionFailure("Hey this assignment didn't work")
    //                return
    //            }
    //
    //            if responseValue.statusCode == 204 {
    //                completion (true)
    //            } else if responseValue.statusCode == 404 {
    //                completion(false)
    //            } else {
    //                print("Other status code \(responseValue.statusCode)")
    //            }
    //            print(data)
    //            print(response)
    //            print(error)
    //        }
    //        task.resume()
    //    }
    
    class func starRepository(fullName: String, completion:() -> ()) {
        
            let gitStarredURL = "\(Secrets.starApiUrl)/\(fullName)"
            
        Alamofire.request(.PUT, gitStarredURL, encoding: .JSON, headers: ["Authorization" : "\(Secrets.token)"])
            .responseJSON { response in
                
                if let responseValue = response.response {
                    
                    if responseValue.statusCode == 204 {
                        
                        print("I am starring repository")
                        completion()
                        
                    }else {
                        
                        print("Star Repo : other status code \(responseValue.statusCode)")
                    }
                }
                
            }
    }
    
        //
        //            let urlString = "\(Secrets.starApiUrl)/\(fullName)"
        //            let url = NSURL(string: urlString)
        //            let session = NSURLSession.sharedSession()
        //            guard let unwrappedURL = url else { fatalError("Invalid URL") }
        //
        //            let request = NSMutableURLRequest(URL: unwrappedURL)
        //            request.HTTPMethod = "PUT"
        //            request.addValue("\(Secrets.token)", forHTTPHeaderField: "Autorisation")
        //
        //            let task = session.dataTaskWithRequest(request) { (data, response, error) in
        //                guard let responseValue = response as? NSHTTPURLResponse else {
        //                    assertionFailure("Hey this assignment didn't work")
        //                    return
        //                }
        //
        //                if responseValue.statusCode == 204 {
        //                    completion()
        //                } else {
        //                    print("Other status code \(responseValue.statusCode)")
        //                }
        //                print(data)
        //                print(response)
        //                print(error)
        //            }
        //            task.resume()
        
        
        
    
    
    class func unStarRepository(fullName: String, completion:() -> ()) {
        
        
        let gitStarredURL = "\(Secrets.starApiUrl)/\(fullName)"
        
        Alamofire.request(.DELETE, gitStarredURL, encoding: .JSON, headers: ["Authorization" : "\(Secrets.token)"])
            .responseJSON { response in
            
            if let responseValue = response.response {
                
                if responseValue.statusCode == 204 {
                    
                    print("I am unstarring repository")
                    completion()
                    
                }else {
                    
                    print("Unstar Repo : other status code \(responseValue.statusCode)")
                }
            }
        }
    }
        
        
        //            let urlString = "\(Secrets.starApiUrl)/\(fullName)"
        //            let url = NSURL(string: urlString)
        //            let session = NSURLSession.sharedSession()
        //            guard let unwrappedURL = url else { fatalError("Invalid URL") }
        //
        //            let request = NSMutableURLRequest(URL: unwrappedURL)
        //            request.HTTPMethod = "DELETE"
        //            request.addValue("\(Secrets.token)", forHTTPHeaderField: "Autorisation")
        //
        //            let task = session.dataTaskWithRequest(request) { (data, response, error) in
        //                guard let responseValue = response as? NSHTTPURLResponse else {
        //                    assertionFailure("Hey this assignment didn't work")
        //                    return
        //                }
        //
        //                if responseValue.statusCode == 204 {
        //                    completion()
        //                } else {
        //                    print("Other status code \(responseValue.statusCode)")
        //                }
        //                print(data)
        //                print(response)
        //                print(error)
        //            }
        //            task.resume()
        
    
}
