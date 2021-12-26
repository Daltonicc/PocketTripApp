//
//  TravelDataStruct.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/22.
//

import Foundation
import RealmSwift

struct TravelData {
    var title: String
    var contentId: Int
    var latitude: Double
    var longitude: Double
}

struct AreaCode {
    let seoul = 1
    let gyeongGiDo = 31
    let busan = 6
    let gyeongNam = 36
    let jeju = 39
}

var travelSpotDictionary: [String:Int] = [:]

//관광지 딕셔너리 만들어주는 함수
func updatingDictionary(spotData: [TravelData]) {
    for i in 0..<spotData.count {
        travelSpotDictionary.updateValue(spotData[i].contentId, forKey: spotData[i].title)
    }
}
