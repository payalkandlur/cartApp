//
//  ViewController.swift
//  cartApp
//
//  Created by Payal Kandlur on 06/10/21.
//

import UIKit
import CoreData
import Realm
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var greaterBtn: UIButton!
    @IBOutlet weak var lesserBtn: UIButton!
    var viewModel = ProductViewModel()
    var products: [NSManagedObject] = []
    var array : [Product]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Register table view cells.
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        self.registerViewModelListeners()
        
    }
    @IBAction func greaterThanTapped(_ sender: Any) {
        viewModel.sortGreater()
        array = viewModel.filteredList
        tableView.reloadData()
    }
    @IBAction func lesserThanTapped(_ sender: Any) {
        viewModel.sortLesser()
        array = viewModel.filteredList
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CommonUtils.sharedInstance.showActivityIndicator(self.view)
        viewModel.getProducts()
        applyTheme()
    }
    
    func applyTheme(){
        self.lesserBtn.layer.cornerRadius = 10
        self.greaterBtn.layer.cornerRadius = 10
    }
    
    @IBAction func cartBtnTapped(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "CartViewController") as? CartViewController else { return }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func registerViewModelListeners() {
        viewModel.isGetListSuccess.bind { [self] success in
            if success {
                //Hidingh activity indicator after fetching the list
                CommonUtils.sharedInstance.hideActivityIndicator()
                array = viewModel.productList
                //reload table view after fethcing data
                self.tableView.reloadData()
                
            } else {
                CommonUtils.sharedInstance.hideActivityIndicator()
                CommonUtils.sharedInstance.showAlert(header: ErrorConstants.defaultErrorHeader, message: StringConstants.textFieldValidation, actionTitle: StringConstants.alertOK)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ProductTableViewCell?  else { return UITableViewCell() }
            cell?.nameLabel.text = array?[indexPath.row].name
        cell?.priceLabel.text = "₹" + (array?[indexPath.row].price)!
        cell?.ratingLabel.text = "Rating: " + String((array?[indexPath.row].rating)!)
            
            if let imageUrlString = array?[indexPath.row].image_url {
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
        
        //set button action
        cell?.addProductActionType {
            self.save(name:  self.array?[indexPath.row].name, image_url: self.array?[indexPath.row].image_url, rating: String((self.array?[indexPath.row].rating)!))
        }
       
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func save(name: String?, image_url: String?, rating: String?) {
        
        let model = Product()
        model.name = name
        model.image_url = image_url
        model.rating = Int(rating!)
        
        //Add data to database
        RealmManager.sharedManager.addObjects(model)
        
    }
    
}
