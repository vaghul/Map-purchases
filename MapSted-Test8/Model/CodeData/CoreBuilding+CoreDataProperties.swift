//
//  CoreBuilding+CoreDataProperties.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-06.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreBuilding {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreBuilding> {
        return NSFetchRequest<CoreBuilding>(entityName: "CoreBuilding")
    }

    @NSManaged public var city: String?
    @NSManaged public var building_name: String?
    @NSManaged public var state: String?
    @NSManaged public var building_id: Int32
    @NSManaged public var country: String?

}
