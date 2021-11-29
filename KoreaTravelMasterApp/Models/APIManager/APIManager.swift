//
//  APIManager.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    
    static let shared = APIManager()
    
    var titleData: String = ""
    var overviewData: String = ""
    var imageData: String = ""
    var contentId: Int = 0
    var getData: [TravelData] = []
    
    func getSpotDetailData(contentId: Int, result:@escaping (JSON) -> ()) {
        
        let url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?ServiceKey=x1Yng3r3y6at3kAxxFxixvYzgeDQ00GkPvFRr5lDcV3kZ%2FOkTi6ES0UTWcuAwAJQsd8Ue1U5j4CjCRg3giEa1w%3D%3D&overviewYN=Y&firstImageYN=Y&contentTypeId=12&contentId=\(contentId)&MobileOS=ETC&MobileApp=AppTest&_type=json"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let overview = json["response"]["body"]["items"]["item"]["overview"].stringValue.replacingOccurrences(of: "<br>", with: "")
                let overview2 = overview.replacingOccurrences(of: "<br />", with: "\n")
                let image = json["response"]["body"]["items"]["item"]["firstimage"].stringValue
                let contentId = json["response"]["body"]["items"]["item"]["contentid"].intValue

                self.overviewData = overview2
                self.imageData = image
                self.contentId = contentId
                
                result(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //서울이랑 경기도 필수데이터 앱에 내장시키기 위해 만들어준거 나중에 지워야함
    func getSeoulData() {
        
        let url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=x1Yng3r3y6at3kAxxFxixvYzgeDQ00GkPvFRr5lDcV3kZ%2FOkTi6ES0UTWcuAwAJQsd8Ue1U5j4CjCRg3giEa1w%3D%3D&areaCode=31&numOfRows=450&contentTypeId=12&&cat1=A02&cat2=A0201&MobileOS=ETC&MobileApp=AppTest&_type=json"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for item in json["response"]["body"]["items"]["item"].arrayValue {
                    
                    let title = item["title"].stringValue
                    let contentId = item["contentid"].intValue
                    let latitude = item["mapy"].doubleValue
                    let longitude = item["mapx"].doubleValue
                    
                    let data = TravelData(title: title, contentId: contentId, latitude: latitude, longitude: longitude)
                    
                    self.getData.append(data)
                }
                
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
}
