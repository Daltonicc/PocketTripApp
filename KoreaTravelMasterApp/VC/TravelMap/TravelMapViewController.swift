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

class TravelMapViewController: UIViewController {

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
    let localRealm = try! Realm()
    let locationManager = CLLocationManager()
    var region = MyRegion.myRegion
    
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
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(#function)
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
            seoulAnnotationSetting()
        case "경기도":
            gyeongGiDoAnnotationSetting()
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


