//
//  AboutTableViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 06/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if let link = URL(string: LinksList.site.rawValue) {
                UIApplication.shared.open(link)
            }
        case 1:
            if let link = URL(string: LinksList.instagram.rawValue) {
                UIApplication.shared.open(link)
            }
        case 2:
            if let link = URL(string: LinksList.vk.rawValue) {
                UIApplication.shared.open(link)
            }
        default:
            break
        }
    }
}
