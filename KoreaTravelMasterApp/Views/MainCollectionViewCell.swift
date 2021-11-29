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
    let localRealm = try! Realm()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func cellconfiguration(row: Int) {
        
        switch row {
        case 1:
            gyeongGiDoConfigure()
            regionHidden()
        case 2:
            seoulConfigure()
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
    
    func gyeongGiDoConfigure() {
        
        let gyeongGiDoPercent = round(Double(gyeongGiDoSpotListDidStamp.count) / Double(708) * 1000) / 10

        switch gyeongGiDoPercent {
        case 0...24.99: mainImageView.image = UIImage(named: "GyeongGiDo0")
        case 25...49.99: mainImageView.image = UIImage(named: "GyeongGiDo25")
        case 50...74.99: mainImageView.image = UIImage(named: "GyeongGiDo50")
        case 75...99.99: mainImageView.image = UIImage(named: "GyeongGiDo75")
        case 100:
            if gyeongGiDoSpotListDidStamp.count == 708 {
                mainImageView.image = UIImage(named: "GyeongGiDo100")
            } else {
                mainImageView.image = UIImage(named: "GyeongGiDo75")
            }

        default: mainImageView.image = UIImage(named: "GyeongGiDo0")
        }
    }
    
    func seoulConfigure() {
        
        let seoulPercent = round(Double(seoulSpotListDidStamp.count) / Double(255) * 1000) / 10
        
        switch seoulPercent {
        case 0...24.99: mainImageView.image = UIImage(named: "Seoul0")
        case 25...49.99: mainImageView.image = UIImage(named: "Seoul25")
        case 50...74.99: mainImageView.image = UIImage(named: "Seoul50")
        case 75...99.99: mainImageView.image = UIImage(named: "Seoul75")
        case 100:
            if seoulSpotListDidStamp.count == 255 {
                mainImageView.image = UIImage(named: "Seoul100")
            } else {
                mainImageView.image = UIImage(named: "Seoul75")
            }
                
        default: mainImageView.image = UIImage(named: "Seoul0")
        }
    }
}
