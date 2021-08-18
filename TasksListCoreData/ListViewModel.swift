//
//  ListViewModel.swift
//  TasksListCoreData
//
//  Created by Tatiana Dmitrieva on 18/08/2021.
//

import Foundation

class ListViewModel {
    
    var Listarray = [List]()
    
    let coreDataManager = CoreDataManager()
    
    func fetchData() {
        Listarray = coreDataManager.fetchData() ?? [List]()
    }
    
    func saveData(title: String) {
        coreDataManager.saveData(title: title)
    }
    
    func deleteData(index: Int) {
        coreDataManager.deleteData(index: index)
        
    }
    func updateData() {
        
    }
}
