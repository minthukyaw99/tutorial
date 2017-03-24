//
//  MealTableViewController.swift
//  AppleTutorial
//
//  Created by Min thu Kyaw on 3/9/17.
//  Copyright © 2017 Min thu Kyaw. All rights reserved.
//

import UIKit
import CoreData

class MealTableViewController: CoreDataTableViewController, UISearchBarDelegate {
    
    //MARK: Properties
    
    var meals = [Meal]()
    var searchStatus:Bool = false
    var filteredMeal = [Meal]()
    var managedObjectContex : NSManagedObjectContext?
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Private Functions
    
    private func loadData() {
        print("loading data")
        if let contex = self.managedObjectContex {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Meal")
            request.sortDescriptors = [NSSortDescriptor(key: "rating", ascending: true)]
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: contex,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            
        } else {
            fetchedResultsController = nil
        }
        
    }
    
    func insertIntoTableView(_ sender: MealViewController ) {
        print ("being called")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data.
        
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        self.searchBar.delegate = self
        
        let coreDataManager = CoreDataManager.init(modelName: "Model1")
        
        self.managedObjectContex = coreDataManager.managedObjectContext
        
        loadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let mealViewController = segue.destination as? MealViewController
        
        switch segue.identifier ?? "" {
        case "addNewMeal":
            print("going to add meal")
        case "showDetail":
            guard let selectedMealCell = sender as? MealTableViewCell else {
                print("Could not get MealCell")
                return
            }
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                print("Could not get indexPath")
                return
            }
            
            let meal = fetchedResultsController?.object(at: indexPath)
            mealViewController?.meal = meal as! Meal?
            
        default:
            print("not segue")
        }
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let svc = sender.source as? MealViewController {
            
            if let meal = NSEntityDescription.insertNewObject(forEntityName: "Meal", into: (fetchedResultsController?.managedObjectContext)!) as? Meal {
                meal.name = svc.nameTextField.text
                meal.rating = Int16(svc.ratingControl.rating)
                meal.photo = UIImagePNGRepresentation(svc.photoImageView.image!) as NSData?
                fetchedResultsController?.managedObjectContext.perform({
                    
                    do {
                        try self.fetchedResultsController?.managedObjectContext.save()
                    } catch let Error {
                        print("Could not save to core data \(Error)");
                    }
                    
                })
            }
        }
        print("from unwind")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("Could not create table view cell")
        }
        
        if searchStatus == true {
            let fMeal = filteredMeal[indexPath.row]
            cell.nameLabel.text = fMeal.name
            cell.photoImageView.image = UIImage(data: fMeal.photo as! Data)
            cell.ratingControl.rating = Int(Int16(fMeal.rating))
        } else {
            
            if let meal = fetchedResultsController?.object(at: indexPath) as? Meal {
                cell.nameLabel.text = meal.name
                cell.photoImageView.image = UIImage(data: meal.photo as! Data)
                cell.ratingControl.rating = Int(Int16(meal.rating))
            }
            
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("index number \(indexPath.row)")
            let toDeleteMeal = fetchedResultsController?.object(at: indexPath)
            self.managedObjectContex?.delete(toDeleteMeal as! NSManagedObject)
            self.managedObjectContex?.perform({
                do {
                    try self.managedObjectContex?.save()
                } catch let error {
                    fatalError("Could not delete row \(error)")
                }
            })
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    //MARK: UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchStatus = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchStatus = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchStatus = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchStatus = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMeal = meals.filter({ (meal) -> Bool in
            
            let range = meal.name?.range(of: searchText)
            return range != nil
        })
        
        print(filteredMeal)
        
        if filteredMeal.count == 0 {
            searchStatus = false
        } else {
            searchStatus = true
        }
        
        tableView.reloadData()
    }
    
    
}
