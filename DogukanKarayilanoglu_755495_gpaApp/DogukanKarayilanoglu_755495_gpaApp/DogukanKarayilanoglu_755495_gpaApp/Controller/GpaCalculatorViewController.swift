//
//  GpaCalculatorViewController.swift
//  DogukanKarayilanoglu_755495_gpaApp
//
//  Created by DKU on 17.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit
import AVFoundation

class GpaCalculatorViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var mad3004: UITextField!
    @IBOutlet weak var mad2303: UITextField!
    @IBOutlet weak var mad3463: UITextField!
    @IBOutlet weak var mad3115: UITextField!
    @IBOutlet weak var mad3125: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    weak var viewController : ViewController?
    
    var incomingId = "" ;
    var students = [StudentModal]() ;
    var student : StudentModal? = nil ;
    var credits : [Double] = [] ;
    
    var audioP = AVAudioPlayer() ;
   
    
    var gpa : Double = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mad3004.delegate = self ;
        self.mad2303.delegate = self ;
        self.mad3463.delegate = self ;
        self.mad3115.delegate = self ;
        self.mad3125.delegate = self ;
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(StudentDetailViewController.viewTapped(gestureRecognnizer:))) ;
        view.addGestureRecognizer(tapGesture);
        
        
        let sound  = Bundle.main.path(forResource: "Win", ofType: "wav");
        
         do {
            audioP = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound ?? ""))
               } catch {
                   print("File not reachable")
               }
        
        
        
        
        for student_ in students{
            
            if(student_.studentId == incomingId){
                
                self.student = student_ ;
                break;
            }

         
           
        }
        
                   mad3004.text = self.student!.mad3004;
                   mad2303.text = self.student!.mad2303;
                   mad3463.text = self.student!.mad3463;
                   mad3115.text = self.student!.mad3115;
                   mad3125.text = self.student!.mad3125;
                   

        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func calculateButton(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        var grades : [Double] = [];
        credits  = [] ;
        var credit : Double = 0 ;
        
        student!.mad3004 = mad3004.text!;
        student!.mad2303 = mad2303.text!;
        student!.mad3463 = mad3463.text!;
        student!.mad3115 = mad3115.text!;
        student!.mad3125 = mad3125.text!;
        
        if(mad3004.text?.isEmpty == false){
            grades.append(Double((mad3004.text! as NSString).doubleValue));
            credit += 4 ;
            credits.append(4)
        }
        
        if(mad2303.text?.isEmpty == false){
             grades.append(Double((mad2303.text! as NSString).doubleValue));
            credit += 3 ;
            credits.append(3)
        }
        
        if(mad3463.text?.isEmpty == false){
            grades.append(Double((mad3463.text! as NSString).doubleValue));
            credit += 3 ;
            credits.append(3)
               }
        
        if(mad3115.text?.isEmpty == false){
            grades.append(Double((mad3115.text! as NSString).doubleValue));
            credit += 5 ;
            credits.append(5)
               }
        
        if(mad3125.text?.isEmpty == false){
            grades.append(Double((mad3125.text! as NSString).doubleValue));
            credit += 5 ;
            credits.append(5)
               }
        
        gpa = calculate(grades: grades , credit: credit);
        let resultInViewFormat = Double(round(1000*gpa)/1000)
        student!.gpa = gpa ;
        
        if(gpa>=0){
             resultLabel.text = "  Gpa:\(resultInViewFormat)/4  "
        }
        
        if(gpa >= 2.8){
            audioP.play()
        }
       
        
    
        
    }
    
    func calculate (grades : [Double] , credit : Double ) -> Double{
        var result : Double = 0;
        
        for i in stride(from: 0, to: grades.count, by: 1){
            
            if(grades[i] >= 94){
                          result += 4 * credits[i]
                      }
                      
                      else if(grades[i] >= 87 && grades[i] <= 93){
                          result += 3.7 * credits[i]
                      }
                      
                      else if(grades[i] >= 80 && grades[i] <= 86){
                          result += 3.5 * credits[i]
                                 }
                      else if(grades[i] >= 77 && grades[i] <= 79){
                          result += (3.2 * credits[i])
                        print(credits[i])
                                 }
                      else if(grades[i] >= 73 && grades[i] <= 76){
                          result += 3.0 * credits[i]
                                 }
                      else if(grades[i] >= 70 && grades[i] <= 72){
                          result += 2.7 * credits[i]
                                 }
                      else if(grades[i] >= 67 && grades[i] <= 69){
                          result += 2.3 * credits[i]
                                 }
                      else if(grades[i] >= 63 && grades[i] <= 66){
                          result += 2 * credits[i]
                                 }
                      else if(grades[i] >= 60 && grades[i] <= 62){
                          result += 1.7 * credits[i]
                                 }
                      else if(grades[i] >= 50 && grades[i] <= 59){
                          result += 1 * credits[i]
                                 }
                      else{
                          result+=0
                      }
            
        }
        
  
        result = result / credit
        
        print(result)
  
        
        return result;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewController?.students = self.students;
        viewController?.tableView.reloadData();
        
        if(audioP.isPlaying){
            audioP.stop()
        }
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
