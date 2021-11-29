//
//  CustomAnnotation.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/27.
//

import UIKit
import MapKit


class MyPointAnnotation : MKPointAnnotation {
   var obj : ComparableData?

    init(obj: ComparableData) {
        self.obj = obj
        super.init()
    }
}

enum ComparableData {
    case doneStamp
    case seoulDoneStamp
    case seoulNotDoneStamp
    case gyeonGiDoDoneStamp
    case gyeonGiDoNotDoneStamp
}
