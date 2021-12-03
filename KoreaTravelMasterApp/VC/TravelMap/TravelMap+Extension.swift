//
//  TravelMapViewController+Mapkit.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/23.
//

import Foundation
import UIKit

extension TravelMapViewController {
    
    func mapViewConfigure() {
        
        self.travelMapView.showsUserLocation = true
        self.travelMapView.setUserTrackingMode(.follow, animated: true)
        mapStampView.isHidden = true
    }
    
    func navigationItemConfigure() {
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonAction))
        
        let filterBarButtonItem = UIBarButtonItem(title: "지역", style: .plain, target: self, action: #selector(filterAction))
        filterBarButtonItem.tintColor = .black
        
        navigationItem.rightBarButtonItem = filterBarButtonItem
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    // 위치 서비스 미활성화시 경고 알림.
    func locationAlertConfigure() {
        
        let alert = UIAlertController(title: "주의!", message: "위치 서비스 기능이 꺼져 있습니다. 퍼즐을 모으기 위해 위치 서비스 기능을 켜주세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
        let settingMoveAction = UIAlertAction(title: "설정", style: .default) { _ in
            
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
        
        alert.addAction(okAction)
        alert.addAction(settingMoveAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func distanceAlertConfigure() {
        
        let alert = UIAlertController(title: nil, message: "사용자의 위치로부터 해당 관광지와의 거리가 100m이내일 때 버튼이 활성화됩니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func collectActionAlertConfigure() {
        
        let alert = UIAlertController(title: nil, message: "성공적으로 여행지 퍼즐을 획득했습니다!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { _ in
            self.mapStampView.isHidden = true
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func collectAlreadyDoneAlertConfigure() {
        
        let alert = UIAlertController(title: "이미 퍼즐을 획득한 여행지입니다", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { _ in
            self.mapStampView.isHidden = true
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func doNotHaveStampAlertConfigure() -> Void {
        let alert = UIAlertController(title: "다녀온 곳이 없습니다!", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { _ in
            self.mapStampView.isHidden = true
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func backButtonAction() {

        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func filterAction() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let alreadyGet = UIAlertAction(title: "퍼즐을 획득한 곳만 보기", style: .default) { _ in
            if self.AllSpotListDidStamp.count == 0 {
                self.doNotHaveStampAlertConfigure()
            } else {
                self.doneStampAnnotationSetting()
            }
        }
        
        let seoul = UIAlertAction(title: "서울", style: .default) { _ in
            self.seoulAnnotationSetting()
            self.region = "서울"
        }
        let gyeongGiDO = UIAlertAction(title: "경기도", style: .default) { _ in
            self.gyeongGiDoAnnotationSetting()
            self.region = "경기도"
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(alreadyGet)
        alert.addAction(seoul)
        alert.addAction(gyeongGiDO)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}

