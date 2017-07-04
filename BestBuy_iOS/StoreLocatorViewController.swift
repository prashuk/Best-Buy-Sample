//
//  StoreLocatorViewController.swift
//  BestBuy_iOS
//
//  Created by PRASHUK AJMERA on 4/21/17.
//  Copyright © 2017 Prashuk. All rights reserved.
//

import UIKit
import MapKit

class StoreLocatorViewController: UIViewController {

    @IBOutlet weak var menuBar: UIBarButtonItem!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBar.target = self.revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        let logo = UIImage(named: "bestbuy.png")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
}
