//
//  ViewController.swift
//  DogukanKarayilanoglu_755495_gpaApp
//
//  Created by DKU on 15.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource ,UISearchResultsUpdating {
  
    

    @IBOutlet weak var tableView: UITableView!
    var students = [StudentModal]() ;
    var filteredStudents: [StudentModal] = []
    var index = 0;
    let searchController = UISearchController(searchResultsController: nil)
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //Set search bar features
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Student"
        
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
       
        
       
    }
    
    
    
        ///////////////////////////////////
       ///////////////////////////////////
      ///////////////////////////////////
     //Search logic
    
    //check if search bar empty or not
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    //To check tableview's currently presented results
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
      }
      
    
    //return boolean value if student contains search text
    //and assign students to filteredStudents array
    func filterContentSearchBar(searchText : String ){
        filteredStudents = students.filter{ (student : StudentModal) -> Bool in
            return student.fullName.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData();
     
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        filterContentSearchBar(searchText: searchBar.text!) ;
          
      }
    
  
    
    
    ///////////////////////////////////
    //////////////////////////////////
    /////////////////////////////////

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (isFiltering == true){
            return filteredStudents.count;
        }
        
        else{
            return students.count;
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let student : StudentModal ;
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! StudentCell ;
        
        if(isFiltering == true){
            student = filteredStudents[indexPath.row]
        }
        
        else{
            student = students[indexPath.row]
        }
        
        cell.studentName.text = student.fullName
        
        return cell ;
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {

        tableView.reloadData();
 
    }
    
    @IBAction func gpaCalculationButton(_ sender: UIButton) {
        
        let cell = sender.superview?.superview as! StudentCell
        let indexPath = self.tableView.indexPath(for: cell);
        index = (indexPath?.row)! ;
        
        performSegue(withIdentifier: "gpaCalculation", sender: nil)
       }
    
    
    @IBAction func addStudentButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addStudent", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        if(segue.identifier == "gpaCalculation"){
            
            let vc = segue.destination as! GpaCalculatorViewController;
            
            if(isFiltering == true){
                vc.incomingId = filteredStudents[index].studentId
                   }
                   
                   else{
                       vc.incomingId = students[index].studentId
                   }
            vc.students = self.students;
            vc.viewController = self ;
            
        }
        
        if(segue.identifier == "addStudent"){
               let vc = segue.destination as! StudentDetailViewController;
            //To save students from StudentDetailViewController
            
            
            vc.viewController = self ;
            vc.incomingStudentArray = self.students
            
        }
        
                 
    }
   
}

