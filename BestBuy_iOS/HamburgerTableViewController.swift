//
//  HamburgerTableViewController.swift
//  BestBuy_iOS
//
//  Created by PRASHUK AJMERA on 4/21/17.
//  Copyright © 2017 Prashuk. All rights reserved.
//

import UIKit

class HamburgerTableViewController: UITableViewController {

    var data = ["Home", "Stores", "Cart"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        navigationController?.navigationBar.isHidden = true
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: data[indexPath.row], for: indexPath) as! HamburgerTableViewCell
        cell.hamburgerDataLbl.text = data[indexPath.row]
        let imageName = "p\(indexPath.row).png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        cell.hamburgerDataImg = imageView
        return cell
    }

}
