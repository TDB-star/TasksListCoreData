//
//  CoreDataManager.swift
//  TasksListCoreData
//
//  Created by Tatiana Dmitrieva on 18/08/2021.
//

import UIKit
import CoreData


class CoreDataManager {
    static let shared = CoreDataManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchData() -> [List]? {
        do {
            try self.context.fetch(List.fetchRequest())
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func saveData(title: String) {
        let task = List(context: context)
        task.title = title
        do {
            try self.context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(index: Int) {
        if let dataArray = fetchData() {
            context.delete(dataArray[index])
            do {
                try self.context.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }        
    }
}
