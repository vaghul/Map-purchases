//
//  HomeViewModel.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-06.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit
import CoreData

class HomeViewModel : NSObject {
    
    weak var delegate: ModelDelegate?
    var arrayBulding:[Building]?
    var arrayAnalytics:[Analytics]?
    var arrayDataSource:[TableViewHeaderSource] = []
    
    // Making async call to webrequest and continuing the operation when both the call has been completed. This approach is done as both api's have interdependent data
    let Constants = ConstantString.shared
    let CoreHelper = CoreDataHelper.shared
    
    func prepareTableViewRowModel() { // Pre-Calculating the Default Data
        
        // PrePopulating Purchase Cost Title
        let headerValue1 = [
            TableViewDataSource(
                title: Constants.ConstantTitle.title1,
                selection: Constants.DefaultManufacture,
                value: CoreHelper.retriveAnalyticsPurchaseData(
                    feildName: Constants.PlacehoderManufacture,
                    feildValue: Constants.DefaultManufacture) ?? "NA",
                pickerSource: CoreHelper.retriveUniqueValues(FeildName: Constants.PlacehoderManufacture),
                queryKey: Constants.PlacehoderManufacture),
            TableViewDataSource(
                title: Constants.ConstantTitle.title2,
                selection: Constants.DefaultCategoryID,
                value: CoreHelper.retriveAnalyticsPurchaseData(
                    feildName: Constants.PlacehoderCategoryID,
                    feildValue: Constants.DefaultCategoryID) ?? "NA",
                pickerSource: CoreHelper.retriveUniqueValues(FeildName: Constants.PlacehoderCategoryID),
                queryKey: Constants.PlacehoderCategoryID),
            TableViewDataSource(
                title: Constants.ConstantTitle.title3,
                selection: Constants.DefaultCountry,
                value: CoreHelper.retriveAnalyticsPurchaseData(
                    feildName: Constants.PlacehoderCountry,
                    feildValue: Constants.DefaultCountry) ?? "NA",
                pickerSource: CoreHelper.retriveUniqueValues(FeildName: Constants.PlacehoderCountry),
                queryKey: Constants.PlacehoderCountry
            ),
            TableViewDataSource(
                title: Constants.ConstantTitle.title4,
                selection: Constants.DefaultState,
                value: CoreHelper.retriveAnalyticsPurchaseData(
                    feildName: Constants.PlacehoderState,
                    feildValue: Constants.DefaultState) ?? "NA",
                pickerSource: CoreHelper.retriveUniqueValues(FeildName: Constants.PlacehoderState),
                queryKey: Constants.PlacehoderState
            ),
        ]
        arrayDataSource.append(TableViewHeaderSource(title:  Constants.ConstantHeaderTitle.title1, source: headerValue1))
        
        // PrePopulating Number of Purchase
        
        let headerValue2 = [
            TableViewDataSource(
                title: Constants.ConstantTitle.title5,
                selection: Constants.DefaultItemID,
                value: CoreHelper.retriveAnalyticsPurchaseData(
                    feildName: Constants.PlacehoderItemID,
                    feildValue: Constants.DefaultItemID,
                    isSum: false) ?? "NA",
                isCost: false,
                pickerSource: CoreHelper.retriveUniqueValues(FeildName: Constants.PlacehoderItemID),
                queryKey: Constants.PlacehoderItemID)
        ]
        
        arrayDataSource.append(TableViewHeaderSource(title:  Constants.ConstantHeaderTitle.title2, source: headerValue2))
        
        // PrePopulating Most total Purchase
        
        let headerValue3 = [
            TableViewDataSource(
                title: Constants.ConstantTitle.title6,
                selection: CoreHelper.getMostPurchaseBuilding() ?? "NA")
        ]
        
        arrayDataSource.append(
            TableViewHeaderSource(
                title: Constants.ConstantHeaderTitle.title3,
                source: headerValue3)
        )
    }
    // MARK: - Web Request
    
    func MakeWebRequest(){
        let radQueue = OperationQueue()
        let operation1 = BlockOperation {
            let group = DispatchGroup()
            group.enter()
            self.MakeHTTPRequest(url: ApiUrl.AnalyticsData.url!, PostParam: EmptyRequest(), respStruct: [Analytics](), refValue: .AnalyticsData) { (isValid) in
                group.leave()
            }
            group.enter()
            self.MakeHTTPRequest(url: ApiUrl.BuildingInfos.url!, PostParam: EmptyRequest(), respStruct: [Building](), refValue: .BuildingInfos) { (isValid) in
                group.leave()
            }
            group.wait()
            DispatchQueue.main.async {
                if let data = self.arrayBulding {
                    self.CoreHelper.saveBuldingData(bulding: data)
                }
                print("Building Saved")
                if let data = self.arrayAnalytics {
                    self.CoreHelper.saveAnalyticsData(analytics: data)
                }
                print("Analytics Saved")
                self.prepareTableViewRowModel()
                self.delegate?.completedGroupOperation(refparam: .BuildingAnalyticsGroup)
            }
        }
        
        radQueue.addOperation(operation1)
        
    }
    // Custom HTTP request wrapper for network call. Api refValue is used to handle the response for individual webrequest through overriding and delegation ( Not used in this Task )
    
    func MakeHTTPRequest<B:Encodable,R:Decodable>(url:URL,GetParam:[String:Any]? = nil,PostParam:B?  ,method:HTTPMethod = .GET,respStruct:R,refValue:ApiMethod,completion: @escaping (Bool) -> Void){
        
        NetworkService.shared.fetchResources(url: url, method: method, params: GetParam, body: PostParam) { (result :Result<R, APIServiceError>) in
            switch result {
            case .success(let responce):
                self.handleHTTPResponce(responce, refValue:refValue)
                completion(true)
            case .failure(let error):
                self.handleHTTPError(error.localizedDescription, refValue: refValue)
                completion(false)
            }
        }
    }
    
    // MARK: - Handler Methods
    
    func handleHTTPResponce<E>(_ result: E, refValue: ApiMethod) where E : Decodable {
        if refValue == .AnalyticsData {
            let decodedObj = result as! [Analytics]
            arrayAnalytics = decodedObj
            
        }else if refValue == .BuildingInfos {
            let decodedObj = result as! [Building]
            arrayBulding = decodedObj
        }
    }
    
    func handleHTTPError(_ errorDescription: String, refValue: ApiMethod) {
        if refValue == .AnalyticsData {
            
        }else if refValue == .BuildingInfos {
            
        }
    }
    
    // MARK: - Data Communicator
    
    func numberOfDataSection() -> Int{
        return arrayDataSource.count
    }
    func numberOfRowsIn(section:Int) -> Int{
        return arrayDataSource[section].source.count
    }
    func getPurchaseDataTitleFor(section:Int) -> String{
        return arrayDataSource[section].title
    }
    func getPurchaseDataFor(section:Int,index:Int) -> TableViewDataSource {
        return arrayDataSource[section].source[index]
    }
    
    func setPurchaseDataFor(section:Int,index:Int,data:TableViewDataSource) {
        arrayDataSource[section].source[index] = data
    }
}
