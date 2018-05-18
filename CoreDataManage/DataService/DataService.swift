//
//  DataService.swift
//  CoreDataManage
//
//  Created by NgocAnh on 5/16/18.
//  Copyright © 2018 NgocAnh. All rights reserved.
//

import UIKit
import CoreData

class DataService {
    static var share: DataService = DataService()
    
    private var _students : [Student]?
    
    var students :[Student] {
        get{
            if _students == nil {
                getdata()
            }
            return _students ?? []
        }
        set{
            _students = newValue
        }
    }
    func getdata(){
        _students = []
        do {
            _students = try AppDelegate.context.fetch(Student.fetchRequest()) as? [Student]
            
        }
        catch let error as NSError {
            print(error.userInfo)
        }
    }
    func saveDataToCoreData() {
        AppDelegate.saveContext()
        getdata()
    }
    
    func removeData(from indexPath: IndexPath) {
        guard let object = _students else { return }
        let objectUser = object[indexPath.row]
        AppDelegate.context.delete(objectUser)
        saveDataToCoreData()
    }
}   
