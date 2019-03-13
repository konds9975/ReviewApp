
//
//  ThankYouVC.swift
//  ReviewApp
//
//  Created by Kondya on 13/03/19.
//  Copyright © 2019 Kondya. All rights reserved.
//

import UIKit
@objc protocol ThankYouVCDelegate {
    
    func getThankYouVCDelegate()
    
}
class ThankYouVC: UIViewController {

    var delegate: ThankYouVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.67)
    }
    @IBAction func closeBtnAction(_ sender: UIButton) {
        
        self.delegate?.getThankYouVCDelegate()
       self.dismiss(animated: false, completion: nil)
        
    }
}
