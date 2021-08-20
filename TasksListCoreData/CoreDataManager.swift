//
//  CoreDataManager.swift
//  TasksListCoreData
//
//  Created by Tatiana Dmitrieva on 18/08/2021.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TasksListCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchData(completion: (Result<[List], Error>) -> Void) {
        let fethRequest: NSFetchRequest<List> = List.fetchRequest()
        
        do {
            let tasks = try viewContext.fetch(fethRequest)
            completion(.success(tasks))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func saveData(title: String, completion: (List) -> Void) {
        let task = List(context: viewContext)
        task.title = title
        completion(task)
        saveContext()
    }
    
    func deleteData(_ task: List) {
            viewContext.delete(task)
            saveContext()
    }
    
    func updateTask(_ task: List, newName: String) {
        task.title = newName
        saveContext()
    }
}
