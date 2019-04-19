//
//  StudentsModel.swift
//  On the Map
//
//  Created by John Berndt on 3/16/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

import Foundation

class StudentInformationModel {
    
    static var locations = [StudentInformation]()

    static var lastObjectID : String?
    
    class func sort() {
        
        StudentInformationModel.locations.sort { (lhs: StudentInformation, rhs: StudentInformation) -> Bool in

            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "MM dd, yyyy, HH:mm"
            
            let leftDate = dateFormatterGet.date(from: lhs.updatedAt)
            let rightDate = dateFormatterGet.date(from: rhs.updatedAt)
            
            if let leftD = leftDate, let rightD = rightDate {
                return leftD < rightD
            } else {
                return false
            }
        }
        
    }
}
