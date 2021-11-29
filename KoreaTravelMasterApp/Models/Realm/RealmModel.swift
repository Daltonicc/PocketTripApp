//
//  RealmModel.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/24.
//

import Foundation
import RealmSwift

class MytravelSpotObject: Object {
    
    @Persisted var title: String
    @Persisted var date: Date
    @Persisted var overview: String
    @Persisted var contentId: Int
    @Persisted var image: String
    @Persisted var stampStatus: Bool
    @Persisted var areaCode: Int
    @Persisted var latitude: Double
    @Persisted var longitude: Double
    
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(title: String, date: Date, overview: String, contentId: Int, image: String, stampStatus: Bool, areaCode: Int, latitude: Double, longitude: Double) {
        self.init()
        
        self.title = title
        self.date = date
        self.overview = overview
        self.contentId = contentId
        self.image = image
        self.stampStatus = stampStatus
        self.areaCode = areaCode
        self.latitude = latitude
        self.longitude = longitude
    }
}

