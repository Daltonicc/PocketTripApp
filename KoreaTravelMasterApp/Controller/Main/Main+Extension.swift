//
//  MainViewController+Extension.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/29.
//

import UIKit
import SwiftUI
import RealmSwift

extension MainViewController {
    
    func firstRegionAlert() {
        
        if region == "" {
            let alert = UIAlertController(title: "환영합니다!\n퍼즐을 찾기 전에 먼저 나의 지역을 설정해주세요!", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default) { _ in
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
                let nav = UINavigationController(rootViewController: vc)
                
                nav.modalPresentationStyle = .fullScreen
                
                self.present(nav, animated: true, completion: nil)
            }
            alert.addAction(ok)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //함수 수정 백그라운드 컨피규어 통일
    func BackgroundConfigure(spotListDidStamp: Results<MytravelSpotObject>, AllspotCount: Int, puzzleImage: String) {
        
        let Percent = round(Double(spotListDidStamp.count) / Double(AllspotCount) * 1000) / 10
        
        switch Percent {
        case 0...9.99:  backgroundImageView.image = UIImage(named: "\(puzzleImage)0")
        case 10...29.99: backgroundImageView.image = UIImage(named: "\(puzzleImage)25")
        case 30...59.99: backgroundImageView.image = UIImage(named: "\(puzzleImage)50")
        case 60...99.99: backgroundImageView.image = UIImage(named: "\(puzzleImage)75")
        case 100:
            if spotListDidStamp.count == AllspotCount {
                backgroundImageView.isHidden = true
            } else {
                backgroundImageView.image = UIImage(named: "\(puzzleImage)75")
            }
        default: backgroundImageView.image = UIImage(named: "\(puzzleImage)0")
        }
    }
}
