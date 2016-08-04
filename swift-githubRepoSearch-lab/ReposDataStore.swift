//
//  ReposDataStore.swift
//  swift-githubRepoSearch-lab
//
//  Created by Haaris Muneer on 7/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposDataStore {
    
    static let sharedInstance = ReposDataStore()
    private init() {}
    
    var repositories:[GithubRepository] = []
    
    func getRepositoriesWithCompletion(completion: () -> ()) {
        GithubAPIClient.getRepositoriesWithCompletion { (reposArray) in
            self.repositories.removeAll()
            for dictionary in reposArray {
                guard let repoDictionary = dictionary as? NSDictionary else { fatalError("Object in reposArray is of non-dictionary type") }
                let repository = GithubRepository(dictionary: repoDictionary)
                self.repositories.append(repository)
                
            }
            completion()
        }
    }
    func toggleStarStatusForRepository(repository: GithubRepository, completion:()  -> ()) {
        
        GithubAPIClient.checkIfRepositoryIsStarred(repository.fullName) { (starred) in
            
            if starred == true {
                
                GithubAPIClient.unStarRepository(repository.fullName, completion: {
                    print("Unstarring repository")
                    completion()
                })
            } else {
                GithubAPIClient.starRepository(repository.fullName, completion: {
                    print("Starring repository")
                    completion()
                })
            }
        }
    }

    func searchRepository(name: String) -> [String] {
        
        var result: [String] = []
        
        for repo in repositories {
            
            if repo.fullName.containsString(name) {
                result.append(repo.fullName)
            }
        }
        return result
    }
    
    

}
