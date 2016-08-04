//
//  ReposTableViewController.swift
//  swift-githubRepoSearch-lab
//
//  Created by Haaris Muneer on 7/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    
    let store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.accessibilityLabel = "tableView"
        self.tableView.accessibilityIdentifier = "tableView"
        
        store.getRepositoriesWithCompletion {
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.tableView.reloadData()
            })
        }
    }
    
    @IBAction func searchTapped(sender: AnyObject) {
        
        let searchController: UIAlertController = UIAlertController(title: "Search Github Repos", message: "", preferredStyle: .Alert)
        
        searchController.addTextFieldWithConfigurationHandler { textField -> Void in
            
            textField.text = ""
        }
        
        let searchAction: UIAlertAction = UIAlertAction(title: "Search", style: .Default) { action -> Void in
            
            let textField = searchController.textFields![0] as UITextField
            
            if let searchText = textField.text {
                
                print("Text field: \(searchText)")
                
                let resultArray = self.store.searchRepository(searchText)
                
                print("\(resultArray)")
            }
        }
        
        searchController.addAction(searchAction)
        
        searchController.view.setNeedsLayout()
        
        self.presentViewController(searchController, animated: true, completion: nil)
        
      
           }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.repositories.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath)
        
        let repository:GithubRepository = self.store.repositories[indexPath.row]
        cell.textLabel?.text = repository.fullName
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedRepo = store.repositories[indexPath.row]
        
        
        GithubAPIClient.checkIfRepositoryIsStarred(selectedRepo.fullName) { (starred) in
            
            if starred == true {
                
                let alert = UIAlertController(title: "Toggle", message: "repo was unstarred \(selectedRepo.fullName)", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            } else {
                
                let alert = UIAlertController(title: "Toggle", message: "repo was starred \(selectedRepo.fullName)", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        }
        
        
        store.toggleStarStatusForRepository(selectedRepo) {
            print("Toggling")
        }
    }
}
