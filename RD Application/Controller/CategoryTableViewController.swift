//
//  CategoryTableViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 08/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    // MARK: - Stored Properties
    let cellManager = CellManager()
    var pressedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = pressedButton.titleLabel?.text
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
    }
}

// MARK: - Navigation
extension CategoryTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toProducts" else { return }
        guard let destination = segue.destination as? ProductViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        /// pass data to ProductViewController
        let category = Category.englishNotationName[pressedButton.tag][indexPath.row]
        let title = Category.name[pressedButton.tag][indexPath.row]
        destination.category = category
        destination.title = title
    }
}

// MARK: - UITableView Data Source
extension CategoryTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.name[pressedButton.tag].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        let title = Category.name[pressedButton.tag][indexPath.row]
        let imageName = Category.englishNotationName[pressedButton.tag][indexPath.row]
        
        guard let image = UIImage(named: imageName) else { return cell }
        /// configure cell with image and title
        cellManager.configure(cell, titled: title, with: image)
        return cell
    }
}

// MARK: - UITableView Delegate
extension CategoryTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
