//
//  MainCollectionViewCell.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/20.
//

import UIKit
import RealmSwift

class MainCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainCollectionViewCell"
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var gyeongGiDoImageView: UIImageView!
    @IBOutlet weak var gangWonDoImageView: UIImageView!
    @IBOutlet weak var chungBukImageView: UIImageView!
    @IBOutlet weak var chungNamImageView: UIImageView!
    @IBOutlet weak var jonBukImageView: UIImageView!
    @IBOutlet weak var jonNamImageView: UIImageView!
    @IBOutlet weak var gyeongBukImageView: UIImageView!
    @IBOutlet weak var gyeongNamImageView: UIImageView!
    @IBOutlet weak var jejuDoImageView: UIImageView!
    @IBOutlet weak var dokDoImageView: UIImageView!
    
    var mytravelSpotList: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true")
    }
    var seoulSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 1")
    }
    var gyeongGiDoSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 31")
    }
    var busanSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 6")
    }
    var gyeongNamSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 36")
    }
    var jejuSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 39")
    }
    let localRealm = try! Realm()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func cellconfiguration(row: Int) {
        switch row {
        case 0:
            koreaConfigure()
            regionNotHidden()
        case 1:
            regionMainImageViewConfigure(spotListDidStamp: seoulSpotListDidStamp, allSpotCount: 255, percentImageName: "Seoul")
            regionHidden()
        case 2:
            regionMainImageViewConfigure(spotListDidStamp: busanSpotListDidStamp, allSpotCount: 119, percentImageName: "Busan")
            regionHidden()
        case 3:
            regionMainImageViewConfigure(spotListDidStamp: gyeongGiDoSpotListDidStamp, allSpotCount: 708, percentImageName: "GyeongGiDo")
            regionHidden()
        case 4:
            regionMainImageViewConfigure(spotListDidStamp: gyeongNamSpotListDidStamp, allSpotCount: 729, percentImageName: "GyeongNam")
            regionHidden()
        case 5:
            regionMainImageViewConfigure(spotListDidStamp: jejuSpotListDidStamp, allSpotCount: 279, percentImageName: "Jeju")
            regionHidden()
        default: print("cellDefault")
        }
    }
    
    func regionHidden() {
        
        gyeongGiDoImageView.isHidden = true
        gangWonDoImageView.isHidden = true
        chungBukImageView.isHidden = true
        chungNamImageView.isHidden = true
        jonBukImageView.isHidden = true
        jonNamImageView.isHidden = true
        gyeongBukImageView.isHidden = true
        gyeongNamImageView.isHidden = true
        jejuDoImageView.isHidden = true
        dokDoImageView.isHidden = true
    }
    
    func regionNotHidden() {
        
        gyeongGiDoImageView.isHidden = false
        gangWonDoImageView.isHidden = false
        chungBukImageView.isHidden = false
        chungNamImageView.isHidden = false
        jonBukImageView.isHidden = false
        jonNamImageView.isHidden = false
        gyeongBukImageView.isHidden = false
        gyeongNamImageView.isHidden = false
        jejuDoImageView.isHidden = false
        dokDoImageView.isHidden = false
    }
    
    func koreaConfigure() {
        
        mainImageView.image = UIImage(named: "KoreaForMain")
        //경기도
        if gyeongGiDoSpotListDidStamp.count == 708 {
            gyeongGiDoImageView.image = UIImage(named: "GyeongGiDoForMain100")
        } else {
            gyeongGiDoImageView.image = UIImage(named: "GyeongGiDoForMain")
        }
        //경상남도
        if gyeongNamSpotListDidStamp.count == 729 {
            gyeongNamImageView.image = UIImage(named: "GyeongNamForMain100")
        } else {
            gyeongNamImageView.image = UIImage(named: "GyeongNamForMain")
        }
        //제주도
        if jejuSpotListDidStamp.count == 279 {
            jejuDoImageView.image = UIImage(named: "JejuDoForMain100")
        } else {
            jejuDoImageView.image = UIImage(named: "JejuDoForMain")
        }
//        gyeongGiDoImageView.image = UIImage(named: "GyeongGiDoForMain100")
//        gyeongNamImageView.image = UIImage(named: "GyeongNamForMain100")
//        jejuDoImageView.image = UIImage(named: "JejuDoForMain100")
    }
    
    //지역 configure함수 통일
    func regionMainImageViewConfigure(spotListDidStamp: Results<MytravelSpotObject>, allSpotCount: Int, percentImageName: String) {
        
        let percent = round(Double(spotListDidStamp.count) / Double(allSpotCount) * 1000) / 10
        
        switch percent {
        case 0...9.99: mainImageView.image = UIImage(named: "\(percentImageName)0percent")
        case 10...29.99: mainImageView.image = UIImage(named: "\(percentImageName)10percent")
        case 30...59.99: mainImageView.image = UIImage(named: "\(percentImageName)30percent")
        case 60...99.99: mainImageView.image = UIImage(named: "\(percentImageName)60percent")
        case 100:
            if spotListDidStamp.count == allSpotCount {
                mainImageView.image = UIImage(named: "\(percentImageName)100percent")
            } else {
                mainImageView.image = UIImage(named: "\(percentImageName)60percent")
            }
                
        default: mainImageView.image = UIImage(named: "\(percentImageName)0percent")
        }
    }
}
