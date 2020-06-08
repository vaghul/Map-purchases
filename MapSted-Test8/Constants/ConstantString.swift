//
//  ConstantString.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-06.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit


typealias LabelTitles = (title1: String,title2: String,title3: String,title4: String,title5: String,title6: String)

typealias HeaderTitles = (title1: String,title2: String,title3: String)

class ConstantString {
    
    static let shared = ConstantString()
    
    let CoreDataTotal:String = "Total"
    let CoreDataNestedBulding = "bulding.building_name"
    let CoreDataSumOperator = "sum:"
    let CoreDataCountOperator = "count:"
    let CoreDateCostField = "cost"
    
    let CellIDHomeSectionHeader:String = "HomeSectionHeader"
    let CellIDTotalTypeCell:String = "TotalTypeCell"
    let CellIDUITableView:String = "UITableView"
    
    
    let ConstantHomeTableViewHeight:CGFloat = 50
    let ConstantAppTitle:String = "Mapsted Test Case #8"
    let ConstantMyName:String = "Vaghula Krishnan"
    let ConstantTodayDate:String = "07 June 2020"
    let ConstantCancel:String = "Cancel"
    
    let ConstantTitle:LabelTitles = LabelTitles(title1: "Manufacturer",title2: "Category",title3: "Country",title4: "State",title5: "Item",title6: "Building")
    let ConstantHeaderTitle:HeaderTitles = HeaderTitles(title1: "Purchase Costs",title2: "Number of Purchases",title3: "Most Total Purchases")
    
    let PlacehoderManufacture:String = "manufacturer"
    let PlacehoderCategoryID:String = "item_category_id"
    let PlacehoderCountry:String = "bulding.country"
    let PlacehoderState:String = "bulding.state"
    let PlacehoderItemID:String = "item_id"
    
   let DefaultManufacture:String = "Samsung"
   let DefaultCategoryID:Int = 7
   let DefaultCountry:String = "United States"
   let DefaultState:String = "Ontario"
   let DefaultItemID:Int = 47

}
