//
//  CoreDataHelper.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-06.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit
import CoreData


public enum CoreEntity:String {
    case CoreBuilding
    case CorePurchases
}

class CoreDataHelper {
    
    public static let shared = CoreDataHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Core Data Retrival

    func retriveBuildingData(id:Int? = nil ) -> CoreBuilding? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoreEntity.CoreBuilding.rawValue)
        if let id = id {
            request.predicate = NSPredicate(format: "building_id = %d", id)
        }
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [CoreBuilding]
          //  print(result)
            if result.count > 0 {
                return result[0]
            }
        } catch {
            print("Failed")
        }
        return nil
    }
    
    func retriveUniqueValues(FeildName:String) -> [Any]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoreEntity.CorePurchases.rawValue)
        request.resultType = .dictionaryResultType
        //request.predicate = NSPredicate(format: "\(feildName) = %@", feildName)
        request.returnsObjectsAsFaults = false
        request.propertiesToFetch = [FeildName]
        request.returnsDistinctResults = true
        request.sortDescriptors = [NSSortDescriptor(key: FeildName, ascending: true)]
        do {
            let result = try context.fetch(request) as! [[String:AnyObject]]
            if result.count != 0 {
                return result.map { $0[FeildName]!}
            }
        } catch {
            print("Failed")
        }
        return nil
        
    }
    
    func getMostPurchaseBuilding() -> String?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoreEntity.CorePurchases.rawValue)
        let expressionDesc = NSExpressionDescription()
        expressionDesc.name = ConstantString.shared.CoreDataTotal
        expressionDesc.expression = NSExpression(forFunction: ConstantString.shared.CoreDataSumOperator,
                                                 arguments:[NSExpression(forKeyPath: ConstantString.shared.CoreDateCostField)])
        expressionDesc.expressionResultType = .doubleAttributeType
        request.propertiesToFetch = [expressionDesc,ConstantString.shared.CoreDataNestedBulding]
        request.propertiesToGroupBy = [ConstantString.shared.CoreDataNestedBulding]
        request.sortDescriptors = [NSSortDescriptor(key: ConstantString.shared.CoreDataNestedBulding, ascending: false)]
        request.resultType = .dictionaryResultType
        // request.predicate = NSPredicate(format: "bulding.building_name = %@", "Chinook Centre")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [[String:AnyObject]]
            //let dict = result[0] as [String:Double]
            //print(result)
            if result.count != 0 {
                let oldestUser = result.max { (obj1, obj2) -> Bool in
                    (obj1[ConstantString.shared.CoreDataTotal] as! Double) < (obj2[ConstantString.shared.CoreDataTotal] as! Double)
                }
                return oldestUser?[ConstantString.shared.CoreDataNestedBulding] as? String
            }
        } catch {
            print("Failed")
        }
        return nil
    }
    func retriveAnalyticsPurchaseData(feildName:String,feildValue:Any,isSum:Bool = true) -> String? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoreEntity.CorePurchases.rawValue)
        let expressionDesc = NSExpressionDescription()
        expressionDesc.name = ConstantString.shared.CoreDataTotal
        print("Total \(feildName) : \(feildValue)")
        
        if isSum {
            expressionDesc.expression = NSExpression(forFunction: ConstantString.shared.CoreDataSumOperator,
                                                     arguments:[NSExpression(forKeyPath: ConstantString.shared.CoreDateCostField)])
            expressionDesc.expressionResultType = .doubleAttributeType
            
        }else{
            expressionDesc.expression = NSExpression(forFunction: ConstantString.shared.CoreDataCountOperator,
                                                     arguments:[NSExpression(forKeyPath: ConstantString.shared.CoreDateCostField)])
            expressionDesc.expressionResultType = .integer32AttributeType
        }
        request.propertiesToFetch = [expressionDesc]
        request.resultType = .dictionaryResultType
        if let value = feildValue as? Int {
            request.predicate = NSPredicate(format: "\(feildName) = %d", value)
        }else if let value = feildValue as? String {
            request.predicate = NSPredicate(format: "\(feildName) = %@", value)
        }
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            //let dict = result[0] as [String:Double]
            // print(result)
            if result.count != 0 {
                let returnObj = result[0] as! [String:AnyObject]
                return "\(returnObj[ConstantString.shared.CoreDataTotal]!)"
            }
        } catch {
            
            print("Failed")
        }
        return nil
    }
    
    
    func getCodeDataBuilding(building:Building,entity:NSEntityDescription) {
        let newBuilding = CoreBuilding(entity: entity, insertInto: context)
        if let id = building.building_id {
            newBuilding.building_id = Int32(id)
        }
        if let name = building.building_name {
            newBuilding.building_name = name
        }
        if let city = building.city {
            newBuilding.city = city
        }
        if let state = building.state {
            newBuilding.state = state
        }
        if let country = building.country {
            newBuilding.country = country
        }
    }
    
  // MARK: - Core Data Creation
    
    func saveBuldingData(bulding:[Building]) {
        for item in bulding {
            let entity = NSEntityDescription.entity(forEntityName: CoreEntity.CoreBuilding.rawValue, in: context)
            getCodeDataBuilding(building: item, entity: entity!)
        }
        do {
            //context.automaticallyMergesChangesFromParent = true
            try context.save()
        }catch{
            print("failed saving Buildings")
        }
    }
    func saveAnalyticsData(analytics:[Analytics]) {
        for item in analytics {
            if let manufacturer = item.manufacturer {
                for session in item.usage_statistics?.session_infos ?? [] {
                    if let building_id = session.building_id {
                        // Can use internal Caching of the retrived Bulding so that the same building id need not be retrived multiple times from core data ( Ignored it based on the time constraint )
                        let buildingcoredata = retriveBuildingData(id: building_id)
                        for purchase in session.purchases ?? [] {
                            let entity = NSEntityDescription.entity(forEntityName: CoreEntity.CorePurchases.rawValue, in: context)
                            setCoreDataPurchases(manufacturer: manufacturer, building_id: building_id, purchase: purchase, building: buildingcoredata, entity: entity!)
                        }
                    }
                }
            }
        }
        do {
            try context.save()
        }catch{
            print("failed saving Purchases")
        }
        
    }
    func setCoreDataPurchases(manufacturer:String, building_id:Int, purchase:Purchase,building:CoreBuilding?, entity:NSEntityDescription) {
        
        let newPurchase = CorePurchases(entity: entity, insertInto: context)
        newPurchase.building_id = Int32(building_id)
        newPurchase.manufacturer = manufacturer
        
        if let id = purchase.item_id {
            newPurchase.item_id = Int32(id)
        }
        if let category_id = purchase.item_category_id {
            newPurchase.item_category_id = Int32(category_id)
        }
        if let cost = purchase.cost {
            newPurchase.cost = cost
        }
        newPurchase.bulding = building
        
    }
    
}
