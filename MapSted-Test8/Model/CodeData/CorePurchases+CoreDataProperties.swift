//
//  CorePurchases+CoreDataProperties.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-06.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//
//

import Foundation
import CoreData


extension CorePurchases {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CorePurchases> {
        return NSFetchRequest<CorePurchases>(entityName: "CorePurchases")
    }

    @NSManaged public var item_id: Int32
    @NSManaged public var item_category_id: Int32
    @NSManaged public var cost: Double
    @NSManaged public var building_id: Int32
    @NSManaged public var manufacturer: String?
    @NSManaged public var bulding: CoreBuilding?

}
