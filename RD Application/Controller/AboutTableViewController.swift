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
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
    }
}

// MARK: - UITableViewController Methods
extension AboutTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            /// create url name
            let urlName = UrlList.allCases[indexPath.row].rawValue
            /// open url
            openUrl(withName: urlName)
        case 1:
            /// create phone number
            guard let phoneNumber = PhoneNumbersList.allCases[safe: indexPath.row]?.rawValue else { return }
            /// call number with phone number
            openUrl(withName: phoneNumber)
        default:
            break
        }
    }
}

// MARK: - URL
extension AboutTableViewController {
    /// Open url with url name
    ///
    /// - Parameter urlName: url name or phone number
    func openUrl(withName urlName: String) {
        if let url = URL(string: urlName) {
            UIApplication.shared.open(url)
        }
    }
}
