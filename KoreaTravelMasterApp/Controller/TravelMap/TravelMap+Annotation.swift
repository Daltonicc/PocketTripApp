//
//  TravelMap+AnnotationSetting.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/12/07.
//

import UIKit
import CoreLocation

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
    
    //서울 여행지
    func seoulAnnotationSetting() {
        
        let annotations = travelMapView.annotations
        travelMapView.removeAnnotations(annotations)
        
        for i in 0..<seoulSpotListDidStamp.count {
            let annotation = MyPointAnnotation(obj: ComparableData.seoulDoneStamp)
            annotation.title = seoulSpotListDidStamp[i].title
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: seoulSpotListDidStamp[i].latitude,
                longitude: seoulSpotListDidStamp[i].longitude
            )
            travelMapView.addAnnotation(annotation)
        }
        
        for i in 0..<seoulSpotListNotDidStamp.count {
            let annotation = MyPointAnnotation(obj: ComparableData.seoulNotDoneStamp)
            annotation.title = seoulSpotListNotDidStamp[i].title
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: seoulSpotListNotDidStamp[i].latitude,
                longitude: seoulSpotListNotDidStamp[i].longitude
            )
            travelMapView.addAnnotation(annotation)
        }
    }
    
    //경기도 여행지
    func gyeongGiDoAnnotationSetting() {
        
        let annotations = travelMapView.annotations
        travelMapView.removeAnnotations(annotations)
        
        for i in 0..<gyeongGiDoSpotListDidStamp.count {
            let annotation = MyPointAnnotation(obj: ComparableData.gyeonGiDoDoneStamp)
            annotation.title = gyeongGiDoSpotListDidStamp[i].title
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: gyeongGiDoSpotListDidStamp[i].latitude,
                longitude: gyeongGiDoSpotListDidStamp[i].longitude
            )
            travelMapView.addAnnotation(annotation)
        }
        
        for i in 0..<gyeongGiDoSpotListNotDidStamp.count {
            let annotation = MyPointAnnotation(obj: ComparableData.gyeonGiDoNotDoneStamp)
            annotation.title = gyeongGiDoSpotListNotDidStamp[i].title
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: gyeongGiDoSpotListNotDidStamp[i].latitude,
                longitude: gyeongGiDoSpotListNotDidStamp[i].longitude
            )
            travelMapView.addAnnotation(annotation)
        }
    }
    
    //부산 여행지
    func busanAnnotationSetting() {
        
        let annotations = travelMapView.annotations
        travelMapView.removeAnnotations(annotations)
        
        for i in 0..<busanSpotListDidStamp.count {
            let annotation = MyPointAnnotation(obj: ComparableData.busanDoneStamp)
            annotation.title = busanSpotListDidStamp[i].title
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: busanSpotListDidStamp[i].latitude,
                longitude: busanSpotListDidStamp[i].longitude
            )
            travelMapView.addAnnotation(annotation)
        }
        
        for i in 0..<busanSpotListNotDidStamp.count {
            let annotation = MyPointAnnotation(obj: ComparableData.busanNotDoneStamp)
            annotation.title = busanSpotListNotDidStamp[i].title
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: busanSpotListNotDidStamp[i].latitude,
                longitude: busanSpotListNotDidStamp[i].longitude
            )
            travelMapView.addAnnotation(annotation)
        }
    }
    
    //경상남도 여행지
    func gyeongNamAnnotationSetting() {
        
        let annotations = travelMapView.annotations
        travelMapView.removeAnnotations(annotations)
        
        for i in 0..<gyeongNamSpotListDidStamp.count {
            let annotation = MyPointAnnotation(obj: ComparableData.gyeongNamDoneStamp)
            annotation.title = gyeongNamSpotListDidStamp[i].title
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: gyeongNamSpotListDidStamp[i].latitude,
                longitude: gyeongNamSpotListDidStamp[i].longitude
            )
            travelMapView.addAnnotation(annotation)
        }
        
        for i in 0..<gyeongNamSpotListNotDidStamp.count {
            let annotation = MyPointAnnotation(obj: ComparableData.gyeongNamNotDoneStamp)
            annotation.title = gyeongNamSpotListNotDidStamp[i].title
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: gyeongNamSpotListNotDidStamp[i].latitude,
                longitude: gyeongNamSpotListNotDidStamp[i].longitude
            )
            travelMapView.addAnnotation(annotation)
        }
    }
    
    //제주도 여행지
    func jejuAnnotationSetting() {
        
        let annotations = travelMapView.annotations
        travelMapView.removeAnnotations(annotations)
        
        for i in 0..<jejuSpotListDidStamp.count {
            let annotation = MyPointAnnotation(obj: ComparableData.jejuDoneStamp)
            annotation.title = jejuSpotListDidStamp[i].title
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: jejuSpotListDidStamp[i].latitude,
                longitude: jejuSpotListDidStamp[i].longitude
            )
            travelMapView.addAnnotation(annotation)
        }
        
        for i in 0..<jejuSpotListNotDidStamp.count {
            let annotation = MyPointAnnotation(obj: ComparableData.jejuNotDoneStamp)
            annotation.title = jejuSpotListNotDidStamp[i].title
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: jejuSpotListNotDidStamp[i].latitude,
                longitude: jejuSpotListNotDidStamp[i].longitude
            )
            travelMapView.addAnnotation(annotation)
        }
    }
    
}
