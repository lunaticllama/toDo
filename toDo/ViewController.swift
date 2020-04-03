//
//  ViewController.swift
//  toDo
//
//  Created by Philip Taylor on 3/5/20.
//  Copyright © 2020 Philip Taylor. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var toDoItems = toDoItem.getMockData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.view.backgroundColor = .systemTeal
        self.title = "To Do List"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.didTapAddItemButton(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_todo", for: indexPath)

        if indexPath.row < toDoItems.count
        {
            let item = toDoItems[indexPath.row]
            cell.textLabel?.text = item.title

            let accessory: UITableViewCell.AccessoryType = item.done ? .checkmark : .none
            cell.accessoryType = accessory
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row < toDoItems.count
        {
            let item = toDoItems[indexPath.row]
            item.done = !item.done

            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if indexPath.row < toDoItems.count
        {
            toDoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
 
    @objc func didTapAddItemButton(_ sender: UIBarButtonItem)
    {
        // Create an alert
        let alert = UIAlertController(
            title: "Add Task",
            message: "Name the new task you need to do",
            preferredStyle: .alert)

        // Add a text field to the alert for the new item's title
        alert.addTextField(configurationHandler: nil)

        // Add a "cancel" button to the alert. This one doesn't need a handler
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // Add a "OK" button to the alert. The handler calls addNewToDoItem()
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            if let title = alert.textFields?[0].text
            {
                self.addNewToDoItem(title: title)
            }
        }))

        // Present the alert to the user
        self.present(alert, animated: true, completion: nil)
    }

    private func addNewToDoItem(title: String)
    {
        // The index of the new item will be the current item count
        let newIndex = toDoItems.count

        // Create new item and add it to the todo items list
        toDoItems.append(toDoItem(title: title))

        // Tell the table view a new row has been created
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
    }
    
    
}

