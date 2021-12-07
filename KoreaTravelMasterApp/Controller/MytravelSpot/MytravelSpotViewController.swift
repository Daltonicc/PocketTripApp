//
//  MytravelSpotViewController.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/25.
//

import UIKit
import RealmSwift

class MytravelSpotViewController: UIViewController {

    @IBOutlet weak var myTravelSpotTableView: UITableView!
    
    var mytravelSpotList: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true").sorted(byKeyPath: "date", ascending: false)
    }
    var seoulSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 1").sorted(byKeyPath: "date", ascending: false)
    }
    var gyeongGiDoSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 31").sorted(byKeyPath: "date", ascending: false)
    }
    var busanSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 6").sorted(byKeyPath: "date", ascending: false)
    }
    var gyeongNamSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 36").sorted(byKeyPath: "date", ascending: false)
    }
    var jejuSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 39").sorted(byKeyPath: "date", ascending: false)
    }
    var searchFilterSpotList: Results<MytravelSpotObject>!
    var isFiltering: Bool {
        let searchController = navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let searchBarText = searchController?.searchBar.text?.isEmpty == false
        return isActive && searchBarText
    }
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTravelSpotTableView.delegate = self
        myTravelSpotTableView.dataSource = self
        myTravelSpotTableView.reloadData()
        
        navigationItemConfigure()
        
    }
    
    // MARK: - Method

    func navigationItemConfigure(){
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonAction))
        let allSpotButton = UIBarButtonItem(image: UIImage(named: "allSpotIcon"), style: .plain, target: self, action: #selector(allSpotButtonClicked))
        let searchController = UISearchController(searchResultsController: nil)
        let insideSearchBar = searchController.searchBar.value(forKey: "searchTextField") as? UITextField
        
        insideSearchBar?.backgroundColor = .systemGray4
        
        searchController.searchBar.placeholder = "나의 여행지 검색"
        searchController.searchResultsUpdater = self
    
        navigationItem.title = "나의 여행지"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = allSpotButton
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func backButtonAction() {

        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func allSpotButtonClicked() {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AllTravelSpotViewController") as! AllTravelSpotViewController
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav, animated: true, completion: nil)
    }
}

extension MytravelSpotViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else { return }
        searchFilterSpotList = mytravelSpotList.filter("title CONTAINS[c] '\(text)'")
        
        myTravelSpotTableView.reloadData()
    }
}
