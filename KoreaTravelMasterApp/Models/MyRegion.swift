//
//  MyRegion.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/30.
//

import UIKit

class MyRegion {
    static var myRegion: String = UserDefaults.standard.string(forKey: "region") ?? ""
}
