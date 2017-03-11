//: Playground - noun: a place where people can play

import UIKit
import Foundation


var str = "Hello, playground"
dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
dateString = "2017-03-08 18:25:17"
date1 = dateFormatter.date(from: dateString)

dateString = "2017-02-08 07:45:38"
date2 = dateFormatter.date(from: dateString)

var diffComponents = calendar.components([Calendar.Unit.year, Calendar.Unit.month,  Calendar.Unit.day], from: date2!, to: date1!, options: Calendar.Options.init(rawValue: 0))

print("date1 and date2 are different in (diffComponents.year)years    (diffComponents.month)months and (diffComponents.year)days")