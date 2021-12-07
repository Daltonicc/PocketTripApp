//
//  TravelMapViewController+MapView.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/24.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import CoreLocationUI
import Kingfisher
import RealmSwift

extension TravelMapViewController: CLLocationManagerDelegate {
    
    func checkUserLocationServicesAuthorization() {
        print("1번")
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("iOS 위치 서비스를 켜주세요!")
        }
    }
    
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {

        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            locationAlertConfigure()
        case .authorizedAlways:
            print("Always")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            print("Default")
        }
        
        //정확도 체크 - 풀 정확도시 정확한 위치, 리듀스 정확도시에는 인근의 주요 관공서나 위치를 찍어줌.
        if #available(iOS 14.0, *) {
            let accurancyState = locationManager.accuracyAuthorization
            
            switch accurancyState {
            case .fullAccuracy:
                print("Full Accuracy")
            case .reducedAccuracy:
                print("Reduce Accuracy")
                //얼럿 띄워주기 - 정확도가 적으면 퍼즐 획득이 불가능합니다.
            @unknown default:
                print("Default Accuracy")
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard !(annotation is MKUserLocation) else {
            return nil
        }
        // 어노테이션 뷰 처리해줘야함. 레이블이랑 이미지뷰로 구성하게끔
        var annotationView = travelMapView.dequeueReusableAnnotationView(withIdentifier: "custom")

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        if let annotation = annotationView?.annotation as? MyPointAnnotation {
            //나중에 핀 이미지 지역별 선정할 때 활용!
            switch annotation.obj! {
            case .doneStamp:
                annotationView?.image = UIImage(named: "doneStampPinImage")
            case .seoulDoneStamp:
                annotationView?.image = UIImage(named: "doneStampPinImage")
            case .seoulNotDoneStamp:
                annotationView?.image = UIImage(named: "notDoneStampPinImage")
            case .gyeonGiDoDoneStamp:
                annotationView?.image = UIImage(named: "doneStampPinImage")
            case .gyeonGiDoNotDoneStamp:
                annotationView?.image = UIImage(named: "notDoneStampPinImage")
            case .busanDoneStamp:
                annotationView?.image = UIImage(named: "doneStampPinImage")
            case .busanNotDoneStamp:
                annotationView?.image = UIImage(named: "notDoneStampPinImage")
            case .gyeongNamDoneStamp:
                annotationView?.image = UIImage(named: "doneStampPinImage")
            case .gyeongNamNotDoneStamp:
                annotationView?.image = UIImage(named: "notDoneStampPinImage")
            case .jejuDoneStamp:
                annotationView?.image = UIImage(named: "doneStampPinImage")
            case .jejuNotDoneStamp:
                annotationView?.image = UIImage(named: "notDoneStampPinImage")
            }
        } else {
            print("에러!")
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //스크롤 맨 위로 초기화
        overViewTextView.scrollRangeToVisible(NSRange(location: 0, length: 0))
        if let selectAnnotation = view.annotation as? MKPointAnnotation {
            contentId = travelSpotDictionary["\(selectAnnotation.title!)"] ?? 0
            // 디비에 데이터 없을 때 API 통신
            if selectedAnnotation.first?.overview == "" {
                APIManager.shared.getSpotDetailData(contentId: contentId) { _ in
                    self.mapStampView.isHidden = false
                    self.annotationClicked(annotation: selectAnnotation)
                    self.annotationSaveToDB()
                    self.annotationDistanceCalculate(annotation: selectAnnotation)
                    self.detailImageView.isSkeletonable = true
                    self.detailImageView.showAnimatedSkeleton()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.detailImageView.hideSkeleton(reloadDataAfter: true, transition: .none)
                    })
                }
            } else {
                //데이터 있으면 디비에서 가져옴
                mapStampView.isHidden = false
                annotationDistanceCalculate(annotation: selectAnnotation)
                titleLabel.text = selectedAnnotation.first?.title
                overViewTextView.text = selectedAnnotation.first?.overview
                if let imageURL = URL(string: selectedAnnotation.first!.image) {
                    self.detailImageView.kf.setImage(with: imageURL)
                } else {
                    print("imageURL 없음.")
                }
            }
        } else {
            print("유저위치 클릭됨")
        }
    }
    
    func annotationClicked(annotation: MKPointAnnotation) {
        self.titleLabel.text = annotation.title
        self.overViewTextView.text = APIManager.shared.overviewData
        let image = APIManager.shared.imageData
        if image == "" {
            detailImageView.image = UIImage(named: "defaultImage")
        } else {
            if let imageURL = URL(string: image) {
                self.detailImageView.kf.setImage(with: imageURL)
            } else {

            }
        }
    }
    
    func annotationSaveToDB() {
        
        let selectedData = myTravelSpotList.filter("contentId == \(APIManager.shared.contentId)")
        let overview = APIManager.shared.overviewData
        let image = APIManager.shared.imageData
        
        try! localRealm.write {
            selectedData.setValue("\(overview)", forKey: "overview")
            selectedData.setValue("\(image)", forKey: "image")
        }
    }
    
    //사용자 위치에서 어노테이션까지의 거리 계산하기
    func annotationDistanceCalculate(annotation: MKPointAnnotation) {
        
        let selectedAnnotationLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        if let distanceFromUserLocation = self.travelMapView.userLocation.location?.distance(from: selectedAnnotationLocation) {
            //조건문으로 거리 100미터 이하일 때만 버튼 누를 수 있게 처리
            print(distanceFromUserLocation)
            // 테스트용. 거리 10만으로 지정. 나중에 100으로 바꾸자
            if distanceFromUserLocation > 100 {
                collectButton.isEnabled = false
                cautionButton.isHidden = false
            } else {
                collectButton.isEnabled = true
                cautionButton.isHidden = true
            }
        } else {
            collectButton.isEnabled = false
            cautionButton.isHidden = false
            print("거리 없음.")
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        mapStampView.isHidden = true
    }
    
    //사용자 커스텀 위치 함수
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let coordinate = locations.last?.coordinate {
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            travelMapView.setRegion(region, animated: true)
            
            locationManager.stopUpdatingLocation()
            
        } else {
            print("Location Cannot Find")
        }
    }
    
    //자꾸 에러 뜨는 이유?
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
        print("error")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        checkUserLocationServicesAuthorization()
    }
    
    //낮은 버전일때 대응.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        checkUserLocationServicesAuthorization()
    }
}

extension TravelMapViewController: MKMapViewDelegate {
    
}

/*
 대응해줘야 할 필터 경우의 수
 
 1. 다녀온 곳만
 2. 서울
 3. 경기도
 
 */


