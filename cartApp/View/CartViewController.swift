//
//  CartViewController.swift
//  cartApp
//
//  Created by Payal Kandlur on 07/10/21.
//

import UIKit
import CoreData
import Realm
import RealmSwift

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var products : [Product]?
    var realmDB = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Register table view cells.
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchObjects()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ProductTableViewCell?  else { return UITableViewCell() }
        cell?.nameLabel.text = products?[indexPath.row].name
        cell?.priceLabel.text = "₹" + (products?[indexPath.row].price)!
        cell?.ratingLabel.text = "Rating: " + String((products?[indexPath.row].rating)!)

            if let imageUrlString = products?[indexPath.row].image_url {
                DispatchQueue.global().async {
                    guard let imageUrl = URL(string: imageUrlString) else { return }
                    if let data = try? Data(contentsOf: imageUrl) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell?.imgView?.image = image
                            }
                        }
                    }
                }
            }       
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func fetchObjects()  {
        
        let prods = realmDB.objects(Product.self)
                
        if(!prods.isEmpty)
        {
            for n in prods
            {
                self.products?.append(n)
            }
        }
    }
    
}
