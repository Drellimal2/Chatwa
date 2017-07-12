//
//  PattyPurchaseOptionsViewController.swift
//  Chatwa iOS
//
//  Created by Javon Davis on 7/11/17.
//  Copyright © 2017 Chatwa. All rights reserved.
//

import UIKit
import StoreKit

class PattyPurchaseOptionsViewController: UIViewController {
    @IBOutlet weak var purchaseOptionsTableView: UITableView!
    
    var costs = Constants.Costs.Patties.costs
    var products = [SKProduct]()
    let store = IAPHelper(productIds: Constants.ProductIdentifiers.pattyIdentifiers)
    
    
    // MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        purchaseOptionsTableView.tableFooterView = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reload()
    }
    
    // MARK:- Outlets
    
    @IBAction func dismissController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension PattyPurchaseOptionsViewController {
    func reload() {
        products = []
        
        store.requestProducts(completionHandler: { success, products in
            if success {
                self.products = products!
                self.purchaseOptionsTableView.reloadData()
            } else {
                print("Error getting products")
            }
        })
    }
}

// MARK: - Table view data source

extension PattyPurchaseOptionsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return costs.count
    }
}

extension PattyPurchaseOptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PattyPurchaseOptionCell", for: indexPath)
        
        let cost = costs[indexPath.row]
        cell.textLabel?.text = "\(cost.numberOfPatties) Patties"
        cell.detailTextLabel?.text = String(cost.cost)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        
        store.buyProduct(product)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
