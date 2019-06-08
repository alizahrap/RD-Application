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
    var categoryList: [String]!
    var navigationTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = navigationTitle
    }
}

// MARK: - Navigation
extension CategoryTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

// MARK: - UITableView Data Source
extension CategoryTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        cell.configure()
        
        return cell
    }
}
