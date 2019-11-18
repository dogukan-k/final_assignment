//
//  StudentDetailViewController.swift
//  DogukanKarayilanoglu_755495_gpaApp
//
//  Created by DKU on 15.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit

class StudentDetailViewController: UIViewController ,UITextFieldDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var studentId: UITextField!
    weak var viewController : ViewController?
    var incomingStudentArray : [StudentModal] = [] 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(StudentDetailViewController.viewTapped(gestureRecognnizer:))) ;
        view.addGestureRecognizer(tapGesture);
        
        self.firstName.delegate = self ;
        self.lastName.delegate = self  ;
        self.studentId.delegate = self ;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //If id is taken before returns true
    var isIdTaken: Bool {
        var check = true;
        for student in incomingStudentArray {
            if(student.studentId == studentId.text){
                check =  true
            }
            else{
                check = false
            }
        }
      return check
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if(isIdTaken == true && incomingStudentArray.count > 0){
            //Alert choose another id
             let alert = UIAlertController(title: "Id Is Already Taken", message: "Please enter a different id", preferredStyle: .alert);
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { (okAction) in
                alert.dismiss(animated: true, completion: nil) ;
                
               
            }
            
            alert.addAction(okAction);
            present(alert, animated: true, completion: nil);
        }
        
        else if(firstName.text != "" && lastName.text != "" && studentId.text != ""){
            
            //Alert are you sure unutma
            let alert = UIAlertController(title: "Are you sure?", message: "\(firstName.text!) is now a student.", preferredStyle: .alert);
            let alertSuccesful = UIAlertController(title: "New Contact Saved", message: "", preferredStyle: .alert);
            
            let ok = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                alertSuccesful.dismiss(animated: true) {
                    
                    self.navigationController?.popViewController(animated: true)
                }
            }
                     
                  let okAction = UIAlertAction(title: "Yes, I'm Sure!", style: .default) { (okAction) in
                    alert.dismiss(animated: true) {
                        
                        
                        let student = StudentModal(name : self.firstName.text!, lastName : self.lastName.text!, studentId: self.studentId.text!) ;
                            
                                  
                            self.viewController!.students.append(student);
                        
                        alert.dismiss(animated: true, completion: nil)
                        self.present(alertSuccesful, animated: true, completion: nil);
                        
                        }
                    }
            
                let noAction = UIAlertAction(title: "No Way!", style: .default) { (okAction) in
                        alert.dismiss(animated: true, completion: nil) ;
                    }
            
            alert.addAction(noAction);
            alert.addAction(okAction);
            alertSuccesful.addAction(ok);
            
            present(alert, animated: true, completion: nil);
            
          
            
           
        }
        
        else{
            //Alert fill the boxes
            let alert = UIAlertController(title: "Error", message: "Please fill all the boxes", preferredStyle: .alert);
                       
                       let okAction = UIAlertAction(title: "Ok", style: .default) { (okAction) in
                           alert.dismiss(animated: true, completion: nil) ;
                           
                          
                       }
                       
                       alert.addAction(okAction);
                       present(alert, animated: true, completion: nil);
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        viewController!.tableView.reloadData() ;
    }
    
    //When tapped rather than keyboard , keyboard will closed
    @objc func viewTapped(gestureRecognnizer : UITapGestureRecognizer){

           view.endEditing(true);
       }
    //return button will close the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
}
