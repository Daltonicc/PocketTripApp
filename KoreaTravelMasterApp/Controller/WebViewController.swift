//
//  WebViewController.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/12/02.
//

import UIKit
import WebKit
import RealmSwift

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
    }
    
    func getData() {
        
        guard let myURL = URL(string: url) else { return }
        
        let request = URLRequest(url: myURL)
        webView.load(request)
    }
}
