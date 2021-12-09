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
            seoulConfigure()
            regionHidden()
        case 2:
            BusanConfigure()
            regionHidden()
        case 3:
            gyeongGiDoConfigure()
            regionHidden()
        case 4:
            GyeongNamConfigure()
            regionHidden()
        case 5:
            JejuConfigure()
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
    
    func seoulConfigure() {
        
        let percent = round(Double(seoulSpotListDidStamp.count) / Double(255) * 1000) / 10
        
        switch percent {
        case 0...9.99: mainImageView.image = UIImage(named: "Seoul0percent")
        case 10...29.99: mainImageView.image = UIImage(named: "Seoul10percent")
        case 30...59.99: mainImageView.image = UIImage(named: "Seoul30percent")
        case 60...99.99: mainImageView.image = UIImage(named: "Seoul60percent")
        case 100:
            if seoulSpotListDidStamp.count == 255 {
                mainImageView.image = UIImage(named: "Seoul100percent")
            } else {
                mainImageView.image = UIImage(named: "Seoul60percent")
            }
                
        default: mainImageView.image = UIImage(named: "Seoul0percent")
        }
//        mainImageView.image = UIImage(named: "Seoul100percent")
    }
    
    func gyeongGiDoConfigure() {
        
        let percent = round(Double(gyeongGiDoSpotListDidStamp.count) / Double(708) * 1000) / 10

        switch percent {
        case 0...9.99: mainImageView.image = UIImage(named: "GyeongGiDo0percent")
        case 10...29.99: mainImageView.image = UIImage(named: "GyeongGiDo10percent")
        case 30...59.99: mainImageView.image = UIImage(named: "GyeongGiDo30percent")
        case 60...99.99: mainImageView.image = UIImage(named: "GyeongGiDo60percent")
        case 100:
            if gyeongGiDoSpotListDidStamp.count == 708 {
                mainImageView.image = UIImage(named: "GyeongGiDo100percent")
            } else {
                mainImageView.image = UIImage(named: "GyeongGiDo60percent")
            }

        default: mainImageView.image = UIImage(named: "GyeongGiDo0percent")
        }
//        mainImageView.image = UIImage(named: "GyeongGiDo100percent")
    }
    
    func BusanConfigure() {
        
        let percent = round(Double(busanSpotListDidStamp.count) / Double(119) * 1000) / 10

        switch percent {
        case 0...9.99: mainImageView.image = UIImage(named: "Busan0percent")
        case 10...29.99: mainImageView.image = UIImage(named: "Busan10percent")
        case 30...59.99: mainImageView.image = UIImage(named: "Busan30percent")
        case 60...99.99: mainImageView.image = UIImage(named: "Busan60percent")
        case 100:
            if busanSpotListDidStamp.count == 119 {
                mainImageView.image = UIImage(named: "Busan100percent")
            } else {
                mainImageView.image = UIImage(named: "Busan60percent")
            }

        default: mainImageView.image = UIImage(named: "Busan0percent")
        }
//        mainImageView.image = UIImage(named: "Busan100percent")
    }
    
    func GyeongNamConfigure() {
        
        let percent = round(Double(gyeongNamSpotListDidStamp.count) / Double(729) * 1000) / 10

        switch percent {
        case 0...9.99: mainImageView.image = UIImage(named: "GyeongNam0percent")
        case 10...29.99: mainImageView.image = UIImage(named: "GyeongNam10percent")
        case 30...59.99: mainImageView.image = UIImage(named: "GyeongNam30percent")
        case 60...99.99: mainImageView.image = UIImage(named: "GyeongNam60percent")
        case 100:
            if gyeongNamSpotListDidStamp.count == 729 {
                mainImageView.image = UIImage(named: "GyeongNam100percent")
            } else {
                mainImageView.image = UIImage(named: "GyeongNam60percent")
            }

        default: mainImageView.image = UIImage(named: "GyeongNam0percent")
        }
//        mainImageView.image = UIImage(named: "GyeongNam100percent")
    }
    
    func JejuConfigure() {
        
        let percent = round(Double(jejuSpotListDidStamp.count) / Double(279) * 1000) / 10

        switch percent {
        case 0...9.99: mainImageView.image = UIImage(named: "Jeju0percent")
        case 10...29.99: mainImageView.image = UIImage(named: "Jeju10percent")
        case 30...59.99: mainImageView.image = UIImage(named: "Jeju30percent")
        case 60...99.99: mainImageView.image = UIImage(named: "Jeju60percent")
        case 100:
            if jejuSpotListDidStamp.count == 279 {
                mainImageView.image = UIImage(named: "Jeju100percent")
            } else {
                mainImageView.image = UIImage(named: "Jeju60percent")
            }

        default: mainImageView.image = UIImage(named: "Jeju0percent")
        }
//        mainImageView.image = UIImage(named: "Jeju100percent")
    }
    
}
