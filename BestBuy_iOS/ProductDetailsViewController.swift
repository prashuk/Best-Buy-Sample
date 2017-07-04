//
//  ProductDetailsViewController.swift
//  BestBuy_iOS
//
//  Created by PRASHUK AJMERA on 4/21/17.
//  Copyright © 2017 Prashuk. All rights reserved.
//

import UIKit

var cartNameArray = [String]()
var cartPriceArray = [Double]()
var cartFreeShippingArray = [Bool]()
var cartPrice = Double()

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var menuBar: UIBarButtonItem!
    @IBOutlet weak var upArrowView: UIView!
    @IBOutlet weak var downArrowView: UIView!
    @IBOutlet weak var reviewArea: UIView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var ratings: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var ratingImg: UIImageView!
    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var totalReviews: UILabel!
    @IBOutlet weak var addToCartBtn: UIButton!
    
    var productDetails = NSArray()
    
    var nameStr = String()
    var priceDbl = Double()
    var ratingDbl = Double()
    var imageStr = String()
    var ratingImgStr = String()
    var reviewStr = String()
    var totalReviewStr = String()
    var productListPass = NSArray()
    var isFreeShip = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBar.target = self.revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        let logo = UIImage(named: "bestbuy.png")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        let url = NSURL(string: "https://api.myjson.com/bins/19c7tx")
        URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary {
                    self.productDetails = (json!.value(forKey: "ProductDetails")! as! NSArray)
                    for prodDetailData in self.productDetails {
                        let prodName = (prodDetailData as AnyObject).value(forKey: "Name")
                        let prodPrice = (prodDetailData as AnyObject).value(forKey: "SalePrice")
                        let prodRating = (prodDetailData as AnyObject).value(forKey: "AvgReview")
                        let prodDecs = (prodDetailData as AnyObject).value(forKey: "Description")
                        let prodImg = (prodDetailData as AnyObject).value(forKey: "Image")
                        let prodFreeShip = (prodDetailData as AnyObject).value(forKey: "isFreeShipping")
                        
                        self.nameStr = (prodName as! String)
                        self.name.text = self.nameStr
                        
                        self.priceDbl = (prodPrice as! Double)
                        self.price.textColor = UIColor.red
                        self.price.text = "OnSale: $" + String(self.priceDbl)
                        
                        self.ratingDbl = (prodRating as! Double)
                        self.ratings.text = "Average Rating: " + String(self.ratingDbl)
                        
                        self.reviewStr = (prodDecs as! String)
                        self.review.text = self.reviewStr
                        
                        let imgURL = NSURL(string: (prodImg as! String))
                        if imgURL != nil {
                            let data = NSData(contentsOf: imgURL! as URL)
                            self.image.image = UIImage(data: data! as Data)
                        }
                        
                        self.isFreeShip = (prodFreeShip as! Bool)
                    }
            }
        }.resume()
        downArrowView.isHidden = true
    }

    @IBAction func addToCartTap(_ sender: Any) {
        let alert = UIAlertController(title: "Added To Cart", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        cartNameArray.append(nameStr)
        cartPriceArray.append(priceDbl)
        cartFreeShippingArray.append(isFreeShip)
        cartPrice = cartPrice + priceDbl
    }
    
    @IBAction func upArrowTap(_ sender: Any) {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseIn, animations: {
            self.upArrowView.frame = CGRect(x: 67, y: 385, width: self.upArrowView.frame.width, height: self.upArrowView.frame.height)
            self.downArrowView.frame = CGRect(x: 67, y: 385, width: self.downArrowView.frame.width, height: self.downArrowView.frame.height)
            self.reviewArea.frame = CGRect(x: 16, y: 410, width: self.reviewArea.frame.width, height: self.reviewArea.frame.height)
        }, completion: nil)
        upArrowView.isHidden = true
        downArrowView.isHidden = false
    }
    
    @IBAction func downArrowTap(_ sender: Any) {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseIn, animations: {
            self.upArrowView.frame = CGRect(x: 67, y: 633, width: self.upArrowView.frame.width, height: self.upArrowView.frame.height)
            self.downArrowView.frame = CGRect(x: 67, y: 633, width: self.downArrowView.frame.width, height: self.downArrowView.frame.height)
            self.reviewArea.frame = CGRect(x: 16, y: 668, width: self.reviewArea.frame.width, height: self.reviewArea.frame.height)
        }, completion: nil)
        downArrowView.isHidden = true
        upArrowView.isHidden = false
    }
    
    @IBAction func backToProductDetails(segue: UIStoryboardSegue) {}

}
