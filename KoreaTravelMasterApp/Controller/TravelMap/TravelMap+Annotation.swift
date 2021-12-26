//
//  TravelMap+AnnotationSetting.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/12/07.
//

import UIKit
import CoreLocation
import RealmSwift
import MapKit

extension TravelMapViewController {
    
    //다녀온 곳만 보여줄 때(전체 데이터에서)
    func doneStampAnnotationSetting() {
        
        let annotations = travelMapView.annotations
        travelMapView.removeAnnotations(annotations)
        
        for i in 0..<AllSpotListDidStamp.count {
            let annotation = MyPointAnnotation(obj: ComparableData.doneStamp)
            annotation.title = AllSpotListDidStamp[i].title
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: AllSpotListDidStamp[i].latitude,
                longitude: AllSpotListDidStamp[i].longitude
            )
            travelMapView.addAnnotation(annotation)
        }
    }
    
    //어노테이션 함수 통일
    func annotationSetting(didSpotList: Results<MytravelSpotObject>!, notDidSpotList: Results<MytravelSpotObject>!, stampRegion: ComparableData, notStampRegion: ComparableData) {
        let annotations = travelMapView.annotations
        travelMapView.removeAnnotations(annotations)
            
        for i in 0..<didSpotList.count {
            let annotation = MyPointAnnotation(obj: stampRegion)
            annotation.title = didSpotList[i].title
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: didSpotList[i].latitude,
                longitude: didSpotList[i].longitude
            )
            travelMapView.addAnnotation(annotation)
        }
        
        for i in 0..<notDidSpotList.count {
            let annotation = MyPointAnnotation(obj: notStampRegion)
            annotation.title = notDidSpotList[i].title
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: notDidSpotList[i].latitude,
                longitude: notDidSpotList[i].longitude
            )
            travelMapView.addAnnotation(annotation)
        }
    }
}
