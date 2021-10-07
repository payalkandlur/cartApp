//
//  ViewController.swift
//  cartApp
//
//  Created by Payal Kandlur on 06/10/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = ProductViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Register table view cells.
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        self.registerViewModelListeners()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CommonUtils.sharedInstance.showActivityIndicator(self.view)
        viewModel.getProducts()
    }
    
    func registerViewModelListeners() {
        viewModel.isGetListSuccess.bind { [self] success in
            if success {
                //Hidingh activity indicator after fetching the list
                CommonUtils.sharedInstance.hideActivityIndicator()
                
                //reload table view after fethcing data
                self.tableView.reloadData()
                
            } else {
                CommonUtils.sharedInstance.hideActivityIndicator()
                CommonUtils.sharedInstance.showAlert(header: ErrorConstants.defaultErrorHeader, message: StringConstants.textFieldValidation, actionTitle: StringConstants.alertOK)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ProductTableViewCell?  else { return UITableViewCell() }
            cell?.nameLabel.text = viewModel.productList?[indexPath.row].name
        cell?.priceLabel.text = "₹" + (viewModel.productList?[indexPath.row].price)!
        cell?.ratingLabel.text = "Rating: " + String((viewModel.productList?[indexPath.row].rating)!)
            
            if let imageUrlString = viewModel.productList?[indexPath.row].image_url {
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
//            else {
//                return UITableViewCell()
//            }
       
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let vc = storyboard?.instantiateViewController(identifier: "UserDetailsViewController") as? UserDetailsViewController else { return }
//
//        guard let selectedRow = tableView.indexPathForSelectedRow?.row else { return }
//        vc.fname = viewModel.userList?[selectedRow].first_name
//        vc.lname = viewModel.userList?[selectedRow].last_name
//        vc.email = viewModel.userList?[selectedRow].email
//        vc.image = viewModel.userList?[selectedRow].avatar
//
//        navigationController?.pushViewController(vc, animated: true)
    }


}

