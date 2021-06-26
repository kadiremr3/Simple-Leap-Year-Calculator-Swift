//
//  LeapYear.swift
//  Leap Year Calculator
//
//  Created by Kadir Emre on 9.05.2021.
//

import UIKit
import RealmSwift

class LeapYear: Object {
    @objc dynamic var year = Int()
    var imageView = UIImageView()

    func calculateYear(year: Int , imageView: UIImageView) -> Int{
        if year % 4 == 0{
              if (year % 100 == 0) && (year % 400 != 0){
                imageView.image = UIImage(named: "Cross.png")
              }
              else if (year % 100 == 0) && (year % 400 == 0){
                imageView.image = UIImage(named: "Check.png")
              }
              else {
                imageView.image = UIImage(named: "Check.png")
              }
        }else{
            imageView.image = UIImage(named: "Cross.png")
        }
        return year
    }
    
    func randomYear() -> Int {
        
//        let randomYear = LeapYear()
//        randomYear.year = Int.random(in: 0...100000)
//
//        print("this must be the random year\(randomYear.year)")
//
//        return randomYear.year
        
        let randomYear = Int.random(in: 0...10000)
        return randomYear

    }
}
