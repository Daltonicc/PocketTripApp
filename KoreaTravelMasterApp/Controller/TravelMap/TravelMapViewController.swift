//
//  TravelMapViewController.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/21.
//


import UIKit
import MapKit
import CoreLocation
import CoreLocationUI
import Kingfisher
import RealmSwift
import SkeletonView

final class TravelMapViewController: UIViewController {

    // MARK: - Property
    
    @IBOutlet weak var travelMapView: MKMapView!
    @IBOutlet weak var userLocationButton: UIButton!
    @IBOutlet weak var mapStampView: UIView!
    @IBOutlet weak var overViewTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var collectButton: UIButton!
    @IBOutlet weak var cautionButton: UIButton!
    
    var myTravelSpotList: Results<MytravelSpotObject>!
    var AllSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true")
    }
    var selectedAnnotation: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("contentId == \(contentId)")
    }
    var seoulSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 1")
    }
    var seoulSpotListNotDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == false AND areaCode == 1")
    }
    var gyeongGiDoSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 31")
    }
    var gyeongGiDoSpotListNotDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == false AND areaCode == 31")
    }
    var busanSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 6")
    }
    var busanSpotListNotDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == false AND areaCode == 6")
    }
    var gyeongNamSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 36")
    }
    var gyeongNamSpotListNotDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == false AND areaCode == 36")
    }
    var jejuSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 39")
    }
    var jejuSpotListNotDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == false AND areaCode == 39")
    }
    
    let localRealm = try! Realm()
    let locationManager = CLLocationManager()
    var contentId = 0
    var region = MyRegion.myRegion
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        travelMapView.delegate = self
        locationManager.delegate = self
        myTravelSpotList = localRealm.objects(MytravelSpotObject.self)
        
        mapViewConfigure()
        
        stampViewSetting()
        navigationItemConfigure()
        regionSettingWithoutLoacationService()
        locationButtonSetting()
        
        regionAnnotationSwitch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Method
    
    func locationButtonSetting() {
        
        userLocationButton.backgroundColor = .white
        userLocationButton.layer.cornerRadius = 10
    }
    
    func regionSettingWithoutLoacationService() {
        
        let cityHalllocation = CLLocationCoordinate2D(
            latitude: 37.56721585217902,
            longitude: 126.9778526452839
        )
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: cityHalllocation, span: span)
        travelMapView.setRegion(region, animated: true)
    }

    func stampViewSetting() {
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        mapStampView.layer.cornerRadius = 10
        mapStampView.backgroundColor = .white
        mapStampView.layer.shadowOpacity = 0.7
        mapStampView.layer.shadowRadius = 5
        mapStampView.layer.shadowColor = UIColor.gray.cgColor
        mapStampView.layer.shadowOffset = CGSize(width: 5, height: 5)
    
        overViewTextView.isEditable = false
        
        detailImageView.layer.cornerRadius = 10
        detailImageView.backgroundColor = .white
        detailImageView.isSkeletonable = true
        detailImageView.showAnimatedGradientSkeleton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.detailImageView.hideSkeleton(reloadDataAfter: true, transition: .none)
        }
        
        collectButton.layer.cornerRadius = 10
        collectButton.backgroundColor = .white
        collectButton.layer.shadowOpacity = 0.7
        collectButton.layer.shadowRadius = 5
        collectButton.layer.shadowColor = UIColor.gray.cgColor
        collectButton.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    func regionAnnotationSwitch() {
        
        switch region {
        case "서울":
            annotationSetting(
                didSpotList: self.seoulSpotListDidStamp,
                notDidSpotList: self.seoulSpotListNotDidStamp,
                stampRegion: ComparableData.seoulDoneStamp,
                notStampRegion: ComparableData.seoulNotDoneStamp
            )
        case "경기도":
            annotationSetting(
                didSpotList: self.gyeongGiDoSpotListDidStamp,
                notDidSpotList: self.gyeongGiDoSpotListNotDidStamp,
                stampRegion: ComparableData.gyeonGiDoDoneStamp,
                notStampRegion: ComparableData.gyeonGiDoNotDoneStamp
            )
        case "부산":
            annotationSetting(
                didSpotList: self.busanSpotListDidStamp,
                notDidSpotList: self.busanSpotListNotDidStamp,
                stampRegion: ComparableData.busanDoneStamp,
                notStampRegion: ComparableData.busanNotDoneStamp
            )
        case "경상남도":
            annotationSetting(
                didSpotList: self.gyeongNamSpotListDidStamp,
                notDidSpotList: self.gyeongNamSpotListNotDidStamp,
                stampRegion: ComparableData.gyeongNamDoneStamp,
                notStampRegion: ComparableData.gyeongNamNotDoneStamp
            )
        case "제주도":
            annotationSetting(
                didSpotList: self.jejuSpotListDidStamp,
                notDidSpotList: self.jejuSpotListNotDidStamp,
                stampRegion: ComparableData.jejuDoneStamp,
                notStampRegion: ComparableData.jejuNotDoneStamp
            )
        default: print("Default")
        }
    }
    
    @IBAction func userLocationButtonClicked(_ sender: UIButton) {
        
        self.travelMapView.showsUserLocation = true
        self.travelMapView.setUserTrackingMode(.follow, animated: true)
    }
    
    @IBAction func stampViewXmarkButtonClicked(_ sender: UIButton) {
        
        mapStampView.isHidden = true
    }
    
    @IBAction func collectButtonClicked(_ sender: UIButton) {
    
        let selectedData = myTravelSpotList.filter("contentId == \(APIManager.shared.contentId)")
        
        let date = Date()
        let overview = APIManager.shared.overviewData
        let image = APIManager.shared.imageData
        let stampStatus = true
        
        if selectedData.first?.stampStatus == true {
            collectAlreadyDoneAlertConfigure()
        } else {
            try! localRealm.write {
                selectedData.setValue("\(overview)", forKey: "overview")
                selectedData.setValue(date, forKey: "date")
                selectedData.setValue("\(image)", forKey: "image")
                selectedData.setValue(stampStatus, forKey: "stampStatus")
            }
            regionAnnotationSwitch()
            collectActionAlertConfigure()
        }
    }
    
    @IBAction func cautionButtonClicked(_ sender: UIButton) {

        distanceAlertConfigure()
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
}


