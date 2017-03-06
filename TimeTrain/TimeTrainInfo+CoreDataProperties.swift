//
//  TimeTrainInfo+CoreDataProperties.swift
//  TimeTrain
//
//  Created by Joe on 2017/3/2.
//  Copyright © 2017年 SnowBaby. All rights reserved.
//

import Foundation
import CoreData


extension TimeTrainInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimeTrainInfo> {
        return NSFetchRequest<TimeTrainInfo>(entityName: "TimeTrainInfo");
    }

    @NSManaged public var theme: String?
    @NSManaged public var time: String?
    @NSManaged public var timeInterval: String?
    //@NSManaged public var text: String?
    @NSManaged public var text : String?
    @NSManaged public var isFinish:Bool
    
    
    
    
    
    
    
    

}
