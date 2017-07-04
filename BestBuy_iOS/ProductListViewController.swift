//
//  ProductListViewController.swift
//  BestBuy_iOS
//
//  Created by PRASHUK AJMERA on 4/21/17.
//  Copyright © 2017 Prashuk. All rights reserved.
//

import UIKit
import SDWebImage

class ProductListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuBar: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndexPath = Int()
    var productList = NSArray()
    var prodNameArray = [String]()
    var prodIdArray = [String]()
    var prodImageArray = [String]()
    var prodRegularPriceArray = [Double]()
    var prodSalesPriceArray = [Double]()
    var prodisNewProductArray = [Bool]()
    var prodisOnSaleArray = [Bool]()
    var prodAverageReviewArray = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBar.target = self.revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        let logo = UIImage(named: "bestbuy.png")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        for prodData in self.productList {
            let prodName = (prodData as AnyObject).value(forKey: "Name")
            let prodId = (prodData as AnyObject).value(forKey: "Sku")
            let prodImage = (prodData as AnyObject).value(forKey: "Image")
            let prodRegularPrice = (prodData as AnyObject).value(forKey: "RegularPrice")
            let prodSalesPrice = (prodData as AnyObject).value(forKey: "SalesPrice")
            let prodisNewProduct = (prodData as AnyObject).value(forKey: "isNewProduct")
            let prodisOnSale = (prodData as AnyObject).value(forKey: "isOnSale")
            let prodAverageReview = (prodData as AnyObject).value(forKey: "AverageReview")
            
            self.prodNameArray.append(prodName as! String)
            self.prodIdArray.append(prodId as! String)
            self.prodImageArray.append(prodImage as! String)
            self.prodRegularPriceArray.append(prodRegularPrice as! Double)
            self.prodSalesPriceArray.append(prodSalesPrice as! Double)
            self.prodisNewProductArray.append(prodisNewProduct as! Bool)
            self.prodisOnSaleArray.append(prodisOnSale as! Bool)
            self.prodAverageReviewArray.append(prodAverageReview as! Double)
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
        tableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prodNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productListCell")! as! ProductListTableViewCell
        cell.productName.text = prodNameArray[indexPath.row]
        cell.productRating.text = "Average Rating: " + String(prodAverageReviewArray[indexPath.row])
        cell.productImg?.sd_setImage(with: URL(string: prodImageArray[indexPath.row]), placeholderImage: #imageLiteral(resourceName: "appmenuhome"), options: [.continueInBackground, .progressiveDownload])
        if prodisOnSaleArray[indexPath.row] == true {
            cell.productPrice.text = "OnSale: $" + String(prodSalesPriceArray[indexPath.row])
            cell.productPrice.textColor = UIColor.red
            cell.onSale.isHidden = false
        } else {
            cell.productPrice.text = "$" + String(prodRegularPriceArray[indexPath.row])
            cell.productPrice.textColor = UIColor.black
            cell.onSale.isHidden = true
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if prodIdArray[indexPath.row] == "2783415" {
            selectedIndexPath = indexPath.row
            performSegue(withIdentifier: "toProductDetailScreen", sender: nil)
        } else {
            let alert = UIAlertController(title: "Product Details Not Found", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func backToProductList(segue: UIStoryboardSegue) {}
    
}
