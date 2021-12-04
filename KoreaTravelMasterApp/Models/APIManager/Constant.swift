//
//  Constant.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/12/03.
//

import UIKit

struct APIKeyManager {
  let apiKey: String
  init() {
    if let keyPath = Bundle.main.infoDictionary?["API_KEY"] as? String {
      apiKey = keyPath
    } else {
      apiKey = ""
    }
  }
}

