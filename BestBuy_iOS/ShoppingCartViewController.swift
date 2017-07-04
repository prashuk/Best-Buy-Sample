//
//  ShoppingCartViewController.swift
//  BestBuy_iOS
//
//  Created by PRASHUK AJMERA on 4/21/17.
//  Copyright © 2017 Prashuk. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuBar: UIBarButtonItem!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var freeShipping: UILabel!
    @IBOutlet weak var nodata: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var finalValue = 0.0
    
    var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBar.target = self.revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        let logo = UIImage(named: "bestbuy.png")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        for valBool in cartFreeShippingArray {
            if valBool == true {
                flag += 1
            }
        }
        
        if flag == cartNameArray.count {
            freeShipping.isHidden = false
        } else {
            freeShipping.isHidden = true
        }
        
        if cartNameArray.count == 0 {
            totalAmount.isHidden = true
            tableView.isHidden = true
            freeShipping.isHidden = true
        } else {
            totalAmount.isHidden = false
            tableView.isHidden = false
            freeShipping.isHidden = false
        }
        
        totalAmount.text = "Total Amount: $" + String(cartPrice)
        
        tableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell")! as! ShoppingCartTableViewCell
        cell.name?.text = cartNameArray[indexPath.row]
        cell.price.textColor = UIColor.red
        cell.price?.text = "$" + String(cartPriceArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            cartNameArray.remove(at: indexPath.row)
            cartPriceArray.remove(at: indexPath.row)
            cartFreeShippingArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.bottom)
            finalValue = 0.0
            for finalPrice in cartPriceArray {
                finalValue = finalValue + finalPrice
            }
            if finalValue == 0.0 {
                totalAmount.isHidden = true
                tableView.isHidden = true
                freeShipping.isHidden = true
            }
            totalAmount.text = "Total Amount: $" + String(finalValue)
            tableView.reloadData()
        }
    }

}
