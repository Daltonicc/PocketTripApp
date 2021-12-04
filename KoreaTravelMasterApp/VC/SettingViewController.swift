//
//  AwardsViewController.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/28.
//

import UIKit
import Zip
import MobileCoreServices

class SettingViewController: UIViewController {

    @IBOutlet weak var regionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItemConfigure()
        regionLableConfigure()
    }
    
    func regionLableConfigure() {
        
        let region = UserDefaults.standard.string(forKey: "region")
        regionLabel.text = region
    }
    
    
    func navigationItemConfigure() {
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonAction))
        
        navigationItem.title = "설정"
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func documenDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
        }
    }
    
    func presentActivityViewController() {
        
        let fileName = (documenDirectoryPath()! as NSString).appendingPathComponent("PocketTrip.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func myRegionSetting(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let seoul = UIAlertAction(title: "서울", style: .default) { _ in
            MyRegion.myRegion = "서울"
            UserDefaults.standard.set(MyRegion.myRegion, forKey: "region")
            self.regionLabel.text = MyRegion.myRegion
        }
        let gyeongGiDo = UIAlertAction(title: "경기도", style: .default) { _ in
            MyRegion.myRegion = "경기도"
            UserDefaults.standard.set(MyRegion.myRegion, forKey: "region")
            self.regionLabel.text = MyRegion.myRegion
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")

        alert.addAction(seoul)
        alert.addAction(gyeongGiDo)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        var urlPaths = [URL]()
        
        if let path = documenDirectoryPath() {
            let realm = (path as NSString).appendingPathComponent("default.realm")
            
            if FileManager.default.fileExists(atPath: realm) {
                urlPaths.append(URL(string: realm)!)
            } else {
                print("백업파일 존재하지 않음")
            }
        }
        do {
            //압축
            let _ = try Zip.quickZipFiles(urlPaths, fileName: "PocketTrip")
            presentActivityViewController()
        }
        catch {
            print("압축이 되지 않았음.")
        }
    }
    
    @IBAction func restoreButtonClicked(_ sender: UIButton) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    @IBAction func personalInfoButtonClicked(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.url = "https://maze-mozzarella-6e5.notion.site/f6076135522144f7bbcb516967473533"
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func askButtonClicked(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.url = "https://maze-mozzarella-6e5.notion.site/be5406a8e2074bd9a8c01576a109b202"
        
        self.present(vc, animated: true, completion: nil)
    }
    

    @objc func backButtonAction() {
        
        if MyRegion.myRegion == "" {
            showToast(vc: self, message: "지역을 반드시 설정해주셔야 합니다")
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}

extension SettingViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function)
        
        guard let selectedFileURL = urls.first else { return }
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("PocketTrip.zip")
                
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    showToast(vc: self, message: "복구가 완료되었습니다. \n앱을 다시 실행해주세요!")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })
            } catch {
                print("복구 실패")
            }
        } else {
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("PocketTrip.zip")
                
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    showToast(vc: self, message: "복구가 완료되었습니다!")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })
            } catch {
                print("복구 실패")
            }
        }
    }
}
//
