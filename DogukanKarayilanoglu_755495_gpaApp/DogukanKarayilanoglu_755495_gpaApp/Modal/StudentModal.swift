//
//  StudentModal.swift
//  DogukanKarayilanoglu_755495_gpaApp
//
//  Created by DKU on 15.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import Foundation

class StudentModal{
    
    
    var name = "" ;
    var lastName = "" ;
    var studentId = "" ;
    var fullName = "" ;

    var gpa : Double = 0 ;
    
    var mad3004 = "" ;
    var mad2303 = "" ;
    var mad3463 = "" ;
    var mad3115 = "" ;
    var mad3125 = "" ;
    
    


    init(name : String , lastName : String , studentId : String){
        
        self.name = name ;
        self.lastName = lastName ;
        self.studentId = studentId ;
        self.fullName = "\(name) \(lastName)"
        
    }

}
