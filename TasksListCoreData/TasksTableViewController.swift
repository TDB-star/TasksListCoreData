//
//  TasksTableViewController.swift
//  TasksListCoreData
//
//  Created by Tatiana Dmitrieva on 18/08/2021.
//

import UIKit

class TasksTableViewController: UITableViewController {
    
    let viewModel = ListViewModel()
    
    let context = CoreDataManager.shared.context
    
    private var models = [List]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllTasks()
        tableView.reloadData()

    }
    fileprivate func updateTableView() {
        viewModel.fetchData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        showTaskAlert(with: "Add new task", "", "Save", "Cancel", "Enter your task") { text in
            if !text.isEmpty {
                self.createTask(name: text)
                //self.viewModel.saveData(title: text)
               // self.updateTableView()
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
        //return viewModel.Listarray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = models[indexPath.row]
        //let task = viewModel.Listarray[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        cell.contentConfiguration = content
        return cell
    }
    

    
   
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

  
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTask(item: models[indexPath.row])
            tableView.reloadData()
        }
    }
   

    func getAllTasks() {
        do {
             models =  try context.fetch(List.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func createTask(name: String) {
        let newTask = List(context: context)
        newTask.title = name
        do {
            try context.save()
            getAllTasks()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    func deleteTask(item: List) {
        context.delete(item)
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func updateTask(item: List, newName: String) {
        item.title = newName
        do {
            try context.save()
            getAllTasks()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
