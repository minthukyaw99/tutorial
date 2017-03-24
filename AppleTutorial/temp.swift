//
//  MealTableViewController.swift
//  AppleTutorial
//
//  Created by Min thu Kyaw on 3/9/17.
//  Copyright © 2017 Min thu Kyaw. All rights reserved.
//
/*
import UIKit
import CoreData

class MealTableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: Properties
    
    var meals = [Meal]()
    var searchStatus:Bool = false
    var filteredMeal = [Meal]()
    var managedObjectContex : NSManagedObjectContext?
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Private Functions
    
    private func loadSampleMeals() {
        
        self.managedObjectContex?.perform({
            self.meals = Meal.fetchMeals(inManagedObjectContext: self.managedObjectContex!)!
            self.tableView.reloadData()
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data.
        
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        self.searchBar.delegate = self
        
        let coreDataManager = CoreDataManager.init(modelName: "Model1")
        
        self.managedObjectContex = coreDataManager.managedObjectContext
        
        loadSampleMeals()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadSampleMeals()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let mealViewController = segue.destination as? MealViewController
        mealViewController?.delegate = self
        
        
        
        switch segue.identifier ?? "" {
        case "addNewMeal":
            mealViewController?.delegate = self
        case "showDetail":
            guard let selectedMealCell = sender as? MealTableViewCell else {
                print("Could not get MealCell")
                return
            }
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                print("Could not get indexPath")
                return
            }
            
            let meal = meals[indexPath.row]
            mealViewController?.meal = meal
            
        default:
            print("not segue")
        }
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.reloadData()
    }
    
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Update an existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            }
            else {
                
                // Add a new meal.
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
            }
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchStatus == true {
            return filteredMeal.count
        } else {
            return meals.count
        }
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
            let meal = meals[indexPath.row]
            cell.nameLabel.text = meal.name
            cell.photoImageView.image = UIImage(data: meal.photo as! Data)
            cell.ratingControl.rating = Int(Int16(meal.rating))
        }
        
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
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
*/
