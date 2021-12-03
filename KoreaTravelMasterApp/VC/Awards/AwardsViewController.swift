//
//  CompletionViewController.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/19.
//

import UIKit
import RealmSwift

class AwardsViewController: UIViewController {

    @IBOutlet weak var awardsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItemConfigure()
        collectionViewConfigure()
    }

    func navigationItemConfigure() {
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonAction))
        
        navigationItem.title = "업적"
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func collectionViewConfigure() {
        
        let nibName = UINib(nibName: AwardsCollectionViewCell.identifier, bundle: nil)
        awardsCollectionView.delegate = self
        awardsCollectionView.dataSource = self
        awardsCollectionView.register(nibName, forCellWithReuseIdentifier: AwardsCollectionViewCell.identifier)
        
    }
    
    @objc func backButtonAction() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
