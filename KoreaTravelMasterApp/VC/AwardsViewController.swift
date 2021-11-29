//
//  CompletionViewController.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/19.
//

import UIKit

class AwardsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItemConfigure()
    }

    func navigationItemConfigure() {
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonAction))
        
        navigationItem.title = "업적"
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func backButtonAction() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
