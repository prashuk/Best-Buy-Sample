//
//  ViewController.swift
//  BestBuy_iOS
//
//  Created by PRASHUK AJMERA on 4/21/17.
//  Copyright © 2017 Prashuk. All rights reserved.
//

import UIKit

class ProductCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuBar: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchArea: UIView!
    @IBOutlet weak var contentArea: UIView!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    @IBOutlet weak var breadCumText: UILabel!

    var flag = 0
    var count = -1
    var f = 0
    var breadCumArray = ["Home"]
    
    var displayArray = [String]()
    
    var categoryList = NSArray()
    var categoryName = [String]()
    var categoryId = [String]()
    
    var subCategoryList = NSArray()
    var subCategoryName = [String]()
    var subCategoryId = [String]()
    
    var anotherSubCategoryList = NSArray()
    var anotherSubCategoryName = [String]()
    var anotherSubCategoryId = [String]()
    
    var productList = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBar.target = self.revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        let logo = UIImage(named: "bestbuy.png")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
        let url1 = NSURL(string: "https://api.myjson.com/bins/9jigj")
        URLSession.shared.dataTask(with: url1! as URL) { (data, response, error) in
            
            if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary {
                
                self.categoryList = (json!.value(forKey: "Categories")! as! NSArray)
                for catData in self.categoryList {
                    let catName = (catData as AnyObject).value(forKey: "catName")
                    let catId = (catData as AnyObject).value(forKey: "catId")
                    self.categoryName.append(catName as! String)
                    self.categoryId.append(catId as! String)
                    self.displayArray = self.categoryName
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                }
                
            }
        }.resume()
        
        let url2 = NSURL(string: "https://api.myjson.com/bins/153hir")
        URLSession.shared.dataTask(with: url2! as URL) { (data, response, error) in
            
            if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary {
                self.subCategoryList = (json!.value(forKey: "SubCategories")! as! NSArray)
            }
        }.resume()
        
        let url3 = NSURL(string: "https://api.myjson.com/bins/15r2ab")
        URLSession.shared.dataTask(with: url3! as URL) { (data, response, error) in
            
            if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary {
                self.anotherSubCategoryList = (json!.value(forKey: "SubAnotherCategories")! as! NSArray)
            }
        }.resume()
        
        let url4 = NSURL(string: "https://api.myjson.com/bins/qe2vn")
        URLSession.shared.dataTask(with: url4! as URL) { (data, response, error) in
            
            if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary {
                self.productList = (json!.value(forKey: "ProductList")! as! NSArray)
            }
        }.resume()
        
        backBtn.isEnabled = false
        backBtn.tintColor = UIColor.clear
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func searchBtnTap(_ sender: Any) {
        
        if flag == 0 {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                self.searchArea.frame = CGRect(x: 0, y: 65, width: self.searchArea.frame.width, height: self.searchArea.frame.height)
            }, completion: nil)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                self.contentArea.frame = CGRect(x: 0, y: 193, width: self.contentArea.frame.width, height: self.contentArea.frame.height)
                self.tableView.frame = CGRect(x: 0, y: 65, width: Int(self.tableView.frame.width), height: Int(self.tableView.frame.height - 145))
            }, completion: nil)
            flag = 1
            tableView.setContentOffset(CGPoint.zero, animated: true)
        }
        
    }
    
    @IBAction func cancelBtnTap(_ sender: Any) {
        
        if flag == 1 {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                self.searchArea.frame = CGRect(x: 375, y: 65, width: self.searchArea.frame.width, height: self.searchArea.frame.height)
            }, completion: nil)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                self.contentArea.frame = CGRect(x: 0, y: 65, width: self.contentArea.frame.width, height: self.contentArea.frame.height)
                self.tableView.frame = CGRect(x: 0, y: 52, width: Int(self.tableView.frame.width), height: Int(self.tableView.frame.height + 145))
            }, completion: nil)
            flag = 0
            tableView.setContentOffset(CGPoint.zero, animated: true)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell")!
        cell.textLabel?.text = displayArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        count += 1
        f = 0
        if count == 0 {
            let selectedID = categoryId[indexPath.row]
            if selectedID == "abcat0100000" {
                breadCumArray.append(categoryName[indexPath.row])
                breadCumText.text = breadCumArray[0] + " -> " + breadCumArray[1]
                for subCatData in self.subCategoryList {
                    let subCatName = (subCatData as AnyObject).value(forKey: "Name")
                    let subCatId = (subCatData as AnyObject).value(forKey: "Id")
                    self.subCategoryName.append(subCatName as! String)
                    self.subCategoryId.append(subCatId as! String)
                }
            } else {
                f = 1
            }
            if f == 0 {
                displayArray = subCategoryName
                backBtn.isEnabled = true
                backBtn.tintColor = UIColor.black
                tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "SubCategory Not Found", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                count -= 1
            }
        } else if count == 1 {
            let selectedID = subCategoryId[indexPath.row]
            if selectedID == "abcat0101000" {
                breadCumArray.append(subCategoryName[indexPath.row])
                breadCumText.text = breadCumArray[0] + " -> " + breadCumArray[1] + " -> " + breadCumArray[2]
                for anotherSubCatData in self.anotherSubCategoryList {
                    let anotherSubCatName = (anotherSubCatData as AnyObject).value(forKey: "Name")
                    let anotherSubCatId = (anotherSubCatData as AnyObject).value(forKey: "Id")
                    self.anotherSubCategoryName.append(anotherSubCatName as! String)
                    self.anotherSubCategoryId.append(anotherSubCatId as! String)
                }
            } else {
                f = 1
            }
            if f == 0 {
                displayArray = anotherSubCategoryName
                backBtn.isEnabled = true
                backBtn.tintColor = UIColor.black
                tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "SubCategory Not Found", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                count -= 1
            }
        } else if count == 2 {
            let selectedID = anotherSubCategoryId[indexPath.row]
            if selectedID == "abcat0101001" {
                count -= 1
            } else {
                f = 1
            }
            if f == 0 {
                performSegue(withIdentifier: "goToProductList", sender: nil)
            } else {
                let alert = UIAlertController(title: "ProductList Not Found", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                count -= 1
            }
        }
    }
    
    @IBAction func backBtnTap(_ sender: Any) {
        if count == 1 {
            breadCumArray.removeLast()
            breadCumText.text = breadCumArray[0] + " -> " + breadCumArray[1]
            displayArray = subCategoryName
            backBtn.isEnabled = true
            backBtn.tintColor = UIColor.black
            tableView.reloadData()
            count -= 1
        } else if count == 0 {
            breadCumArray.removeLast()
            breadCumText.text = breadCumArray[0]
            displayArray = categoryName
            backBtn.isEnabled = false
            backBtn.tintColor = UIColor.clear
            tableView.reloadData()
            count -= 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProductList" {
            let productListVC = segue.destination as! ProductListViewController
            productListVC.productList = self.productList
        }
    }
    
    @IBAction func backToProductCategory(segue: UIStoryboardSegue) {}
    
}

