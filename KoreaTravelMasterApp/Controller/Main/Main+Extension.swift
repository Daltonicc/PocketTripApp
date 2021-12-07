//
//  MainViewController+Extension.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/29.
//

import UIKit
import SwiftUI

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
    
    func gyeongGiDoBackGroundConfigure() {
        
        let gyeongGiDoPercent = round(Double(gyeongGiDoSpotListDidStamp.count) / Double(708) * 1000) / 10
        
        switch gyeongGiDoPercent {
        case 0...24.99:  backgroundImageView.image = UIImage(named: "GyeongGiDoPuzzle0")
        case 25...49.99: backgroundImageView.image = UIImage(named: "GyeongGiDoPuzzle25")
        case 50...74.99: backgroundImageView.image = UIImage(named: "GyeongGiDoPuzzle50")
        case 75...99.99: backgroundImageView.image = UIImage(named: "GyeongGiDoPuzzle75")
        case 100:
            if gyeongGiDoSpotListDidStamp.count == 708 {
                backgroundImageView.isHidden = true
            } else {
                backgroundImageView.image = UIImage(named: "GyeongGiDoPuzzle75")
            }
        default: backgroundImageView.image = UIImage(named: "GyeongGiDoPuzzle0")
        }
    }
    
    func seoulGroundConfigure() {
        
        let seoulPercent = round(Double(seoulSpotListDidStamp.count) / Double(255) * 1000) / 10
        
        switch seoulPercent {
        case 0...24.99:  backgroundImageView.image = UIImage(named: "SeoulPuzzle0")
        case 25...49.99: backgroundImageView.image = UIImage(named: "SeoulPuzzle25")
        case 50...74.99: backgroundImageView.image = UIImage(named: "SeoulPuzzle50")
        case 75...99.99: backgroundImageView.image = UIImage(named: "SeoulPuzzle75")
        case 100:
            if seoulSpotListDidStamp.count == 255 {
                backgroundImageView.isHidden = true
            } else {
                backgroundImageView.image = UIImage(named: "SeoulPuzzle75")
            }
        default: backgroundImageView.image = UIImage(named: "SeoulPuzzle0")
        }
    }
}