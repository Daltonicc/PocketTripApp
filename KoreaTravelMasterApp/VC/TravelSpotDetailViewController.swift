//
//  TravelSpotDetailViewController.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/27.
//

import UIKit
import RealmSwift
import Kingfisher

class TravelSpotDetailViewController: UIViewController {

    @IBOutlet var spotImageView: UIImageView!
    @IBOutlet var spotOverviewTextView: UITextView!
    
    var spotData: MytravelSpotObject = MytravelSpotObject(title: "", date: Date(), overview: "", contentId: 0, image: "", stampStatus: false, areaCode: 0, latitude: 0, longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItemConfigure()
        spotConfigure()
    }

    // MARK: - Method
    
    func navigationItemConfigure() {
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonAction))
        
        navigationItem.title = spotData.title
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func spotConfigure() {
        
        if let imageURL = URL(string: spotData.image) {
            self.spotImageView.kf.setImage(with: imageURL)
            spotImageView.contentMode = .scaleToFill
        } else {
            spotImageView.image = UIImage(named: "defaultImage")
            spotImageView.contentMode = .scaleAspectFit
        }
        spotOverviewTextView.backgroundColor = .white
        spotOverviewTextView.text = spotData.overview
        spotOverviewTextView.isEditable = false
    }
    
    @objc func backButtonAction() {

        self.dismiss(animated: true, completion: nil)
    }
}
