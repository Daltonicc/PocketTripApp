//
//  MytravelSpotViewController+TabelView.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/25.
//

import UIKit
import RealmSwift

extension MytravelSpotViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return searchFilterSpotList.count
        } else {
            switch section {
            case 0: return seoulSpotListDidStamp.count
            case 1: return gyeongGiDoSpotListDidStamp.count
            default: return 0
            }
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MytravelSpotTabelViewCell.identifier, for: indexPath) as? MytravelSpotTabelViewCell else { return UITableViewCell() }
        
        if isFiltering {
            let filterRow = searchFilterSpotList[indexPath.row]
            cell.cellconfigure(row: filterRow)
            cell.cellSearchConfigure(searchController: navigationItem.searchController!, filterRow: filterRow)
        } else {
            switch indexPath.section {
            case 0:
                let seoulRow = seoulSpotListDidStamp[indexPath.row]
                cell.cellconfigure(row: seoulRow)
            case 1:
                let gyeongGiDoRow = gyeongGiDoSpotListDidStamp[indexPath.row]
                cell.cellconfigure(row: gyeongGiDoRow)
            default: print("Cell Default")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TravelSpotDetailViewController") as! TravelSpotDetailViewController
        let nav = UINavigationController(rootViewController: vc)
        var spotData = mytravelSpotList[indexPath.row]
        
        nav.modalPresentationStyle = .automatic
    
        if isFiltering {
            spotData = searchFilterSpotList[indexPath.row]
        } else {
            switch indexPath.section {
            case 0:
                spotData = seoulSpotListDidStamp[indexPath.row]
            case 1:
                spotData = gyeongGiDoSpotListDidStamp[indexPath.row]
            default: print("didSelect Default")
            }
        }
        vc.spotData = spotData
        self.present(nav, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "") { action, view, completionHandler in
            let alert = UIAlertController(title: "정말 지우시겠습니까?", message: "해당 퍼즐은 지도에서 다시 획득할 수 있습니다", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            cancel.setValue(UIColor.red, forKey: "titleTextColor")
            let ok = UIAlertAction(title: "확인", style: .default) { _ in
            
                try! self.localRealm.write {
                    if self.isFiltering {
                        let filterRow = self.searchFilterSpotList[indexPath.row]
                        filterRow.setValue(false, forKey: "stampStatus")
                        tableView.reloadSections(IndexSet(0...0), with: .automatic)
                    } else {
                        switch indexPath.section {
                        case 0:
                            let seoulRow = self.seoulSpotListDidStamp[indexPath.row]
                            seoulRow.setValue(false, forKey: "stampStatus")
                            tableView.reloadSections(IndexSet(0...0), with: .automatic)
                        case 1:
                            let gyeongGiDoRow = self.gyeongGiDoSpotListDidStamp[indexPath.row]
                            gyeongGiDoRow.setValue(false, forKey: "stampStatus")
                            tableView.reloadSections(IndexSet(1...1), with: .automatic)
                        default: print("trailing Default")
                        }
                    }
                }
            }
            alert.addAction(ok)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if isFiltering {
            return 40
        } else if section == 0 {
            return 40
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        let _ = headerView.safeAreaLayoutGuide
        headerView.bounds = headerView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        let sectionLabel = UILabel()
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 22)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if isFiltering {
            sectionLabel.text = "전체"
            headerView.bounds = headerView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        } else {
            switch section {
            case 0:
                sectionLabel.text = "서울(\(seoulSpotListDidStamp.count)/255)"
                headerView.bounds = headerView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
            case 1:
                sectionLabel.text = "경기도(\(gyeongGiDoSpotListDidStamp.count)/708)"
            default: sectionLabel.text = ""
            }
        }
        headerView.addSubview(sectionLabel)
        return headerView
    }
}
