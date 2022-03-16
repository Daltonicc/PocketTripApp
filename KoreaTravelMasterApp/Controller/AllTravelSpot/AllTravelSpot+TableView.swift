//
//  AllTravelSpotViewController+TableView.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/27.
//

import Foundation
import UIKit
import RealmSwift

extension AllTravelSpotViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return searchFilterSpotList.count
        } else {
            return filterTravelSpotList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllTravelSpotTableViewCell.identifier, for: indexPath) as? AllTravelSpotTableViewCell else { return UITableViewCell() }
        
        if isFiltering {
            let filterRow = searchFilterSpotList[indexPath.row]
            cell.cellConfigure(row: filterRow)
            cell.cellSearchConfigure(searchController: navigationItem.searchController!, filterRow: filterRow)
        } else {
            let row = filterTravelSpotList[indexPath.row]
            cell.cellConfigure(row: row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TravelSpotDetailViewController") as! TravelSpotDetailViewController
        let nav = UINavigationController(rootViewController: vc)
        var spotData = filterTravelSpotList[indexPath.row]
        
        if isFiltering {
            spotData = searchFilterSpotList[indexPath.row]
        }
        //데이터베이스에 내용이 저장되어있으면 바로 보여주고 없으면 API통신 처리
        if spotData.overview == "" {
            APIManager.shared.getSpotDetailData(contentId: spotData.contentId) { [weak self] json in
                let overview = APIManager.shared.overviewData
                let image = APIManager.shared.imageData
                
                try! self?.localRealm.write {
                    spotData.setValue("\(overview)", forKey: "overview")
                    spotData.setValue("\(image)", forKey: "image")
                }
                vc.spotData = spotData
                self?.present(nav, animated: true, completion: nil)
            }
        } else {
            vc.spotData = spotData
            present(nav, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        let _ = headerView.safeAreaLayoutGuide
        headerView.bounds = headerView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        
        let sectionLabel = UILabel()
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 22)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if isFiltering {
            sectionLabel.text = "\(searchFilterSpotList.count)개 찾음"
        } else {
            switch areaCode {
            case 1: sectionLabel.text = "서울"
            case 6: sectionLabel.text = "부산"
            case 31: sectionLabel.text = "경기도"
            case 36: sectionLabel.text = "경상남도"
            case 39: sectionLabel.text = "제주도"
            default: sectionLabel.text = ""
            }
        }
        headerView.addSubview(sectionLabel)
        return headerView
    }
}
