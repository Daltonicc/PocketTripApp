//
//  AllTravelSpotViewController.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/27.
//

import UIKit
import RealmSwift

class AllTravelSpotViewController: UIViewController {

    @IBOutlet var allSpotTableView: UITableView!
    
    var filterTravelSpotList: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("areaCode == \(areaCode)")
    }
    var allTravelSpotList: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self)
    }
    var searchFilterSpotList: Results<MytravelSpotObject>!
    let localRealm = try! Realm()
    var areaCode = 1
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let searchBarText = searchController?.searchBar.text?.isEmpty == false
        return isActive && searchBarText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allSpotTableView.delegate = self
        allSpotTableView.dataSource = self
        
        navigationItemConfigure()
    }
    
    // MARK: - Method
    
    func navigationItemConfigure() {
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonAction))
        let filterBarButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterAction))
        
        let searchController = UISearchController(searchResultsController: nil)
        let insideSearchBar = searchController.searchBar.value(forKey: "searchTextField") as? UITextField
        
        insideSearchBar?.backgroundColor = .systemGray4
        
        searchController.searchBar.placeholder = "여행지 검색"
        searchController.searchResultsUpdater = self
        
        navigationItem.title = "전체 여행지"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = filterBarButton
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func backButtonAction() {

        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func filterAction() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let seoul = UIAlertAction(title: "서울", style: .default) { _ in
            self.areaCode = 1
            self.allSpotTableView.reloadData()
        }
        let busan = UIAlertAction(title: "부산", style: .default) { _ in
            self.areaCode = 6
            self.allSpotTableView.reloadData()
        }
        let gyeongGido = UIAlertAction(title: "경기도", style: .default) { _ in
            self.areaCode = 31
            self.allSpotTableView.reloadData()
        }
        let gyeongNam = UIAlertAction(title: "경상남도", style: .default) { _ in
            self.areaCode = 36
            self.allSpotTableView.reloadData()
        }
        let jeju = UIAlertAction(title: "제주도", style: .default) { _ in
            self.areaCode = 39
            self.allSpotTableView.reloadData()
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(seoul)
        alert.addAction(busan)
        alert.addAction(gyeongGido)
        alert.addAction(gyeongNam)
        alert.addAction(jeju)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}

extension AllTravelSpotViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
    
        guard let text = searchController.searchBar.text else { return }
        searchFilterSpotList = allTravelSpotList.filter("title CONTAINS[c] '\(text)'")
        
        allSpotTableView.reloadData()
    }
    
    
    
}
