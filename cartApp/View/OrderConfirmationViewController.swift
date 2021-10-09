//
//  OrderConfirmationViewController.swift
//  cartApp
//
//  Created by Payal Kandlur on 09/10/21.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var confirmedLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.continueBtn.layer.cornerRadius = 10
        CommonUtils.sharedInstance.showActivityIndicator(self.view)
        self.confirmedLabel.isHidden = true
        self.continueBtn.isHidden = true
        
        ///Hide the Activity Indicator after 10 seconds.
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)) {
            CommonUtils.sharedInstance.hideActivityIndicator()
            self.confirmedLabel.isHidden = false
            self.continueBtn.isHidden = false
            RealmManager.sharedManager.deleteObjects()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
