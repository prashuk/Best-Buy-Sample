//
//  ProductListMoreImagesViewController.swift
//  BestBuy_iOS
//
//  Created by PRASHUK AJMERA on 4/25/17.
//  Copyright © 2017 Prashuk. All rights reserved.
//

import UIKit

class ProductListMoreImagesViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource*/ {
    
    @IBOutlet weak var menuBar: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        menuBar.target = self.revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        let logo = UIImage(named: "bestbuy.png")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        <#code#>
//    }

}
