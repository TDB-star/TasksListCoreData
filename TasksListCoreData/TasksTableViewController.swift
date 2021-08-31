//
//  TasksTableViewController.swift
//  TasksListCoreData
//
//  Created by Tatiana Dmitrieva on 18/08/2021.
//

import UIKit

class TasksTableViewController: UITableViewController {
    
    private var tasks = [List]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllTasks()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        showTaskAlert(with: "Add new task", "", "Save", "Cancel", "Enter your task") { text in
            if !text.isEmpty {
                self.saveTask(task: text)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = tasks[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            CoreDataManager.shared.deleteData(task)
           
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let task = tasks[indexPath.row]
        showTaskAlert(with: "Edit", "Edit your task", "Save", "Cancel", "") { text in
            CoreDataManager.shared.updateTask(task, newName: text)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
   private func getAllTasks() {
        CoreDataManager.shared.fetchData { result in
            switch result {
            case .success(let tasks):
                self.tasks = tasks
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveTask(task: String) {
        CoreDataManager.shared.saveData(title: task) { task in
            self.tasks.append(task)
            self.tableView.insertRows(at: [IndexPath(row: self.tasks.count - 1, section: 0)], with: .automatic)
        }
    }
}
