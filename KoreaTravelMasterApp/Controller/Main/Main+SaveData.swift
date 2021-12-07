//
//  Main+SaveData.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/12/07.
//

import Foundation

extension MainViewController {
    
    func saveSeoulAndGyeongGiSpotDataToDB() {
        
        var nowStatus = UserDefaults.standard.bool(forKey: "doOnce")
        var areaCode = 1
        if nowStatus == false {
            for spotData in travelKorea {
                for i in spotData {
                    let title = i.title
                    let date = Date()
                    let overview = ""
                    let contentId = i.contentId
                    let image = ""
                    let stampStatus = false
                    let latitude = i.latitude
                    let longitude = i.longitude
                            
                    let travelSpotData = MytravelSpotObject(title: title, date: date, overview: overview, contentId: contentId, image: image, stampStatus: stampStatus, areaCode: areaCode, latitude: latitude, longitude: longitude)
                            
                    try! localRealm.write {
                        localRealm.add(travelSpotData)
                    }
                }
                //경기도 데이터도 받아주기 위해 (경기도 지역코드: 31)
                areaCode += 30
            }
        }
        nowStatus = true
        UserDefaults.standard.set(nowStatus, forKey: "doOnce")
    }
    
    func saveSpotDataToDB2(areaCode: Int, spotData: [TravelData]) {
        
        var nowStatus = UserDefaults.standard.bool(forKey: "doOnce\(areaCode)")
        let areaCode = areaCode
        if nowStatus == false {
            for i in spotData {
                let title = i.title
                let date = Date()
                let overview = ""
                let contentId = i.contentId
                let image = ""
                let stampStatus = false
                let latitude = i.latitude
                let longitude = i.longitude
                        
                let travelSpotData = MytravelSpotObject(title: title, date: date, overview: overview, contentId: contentId, image: image, stampStatus: stampStatus, areaCode: areaCode, latitude: latitude, longitude: longitude)
                        
                try! localRealm.write {
                    localRealm.add(travelSpotData)
                }
            }
        }
        nowStatus = true
        UserDefaults.standard.set(nowStatus, forKey: "doOnce\(areaCode)")
    }
}
