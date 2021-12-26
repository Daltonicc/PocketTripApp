//
//  MainViewController.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/19.
//

import UIKit
import RealmSwift

/*
 해결해야할 거
 1. 컬러 블렌디드로 영역확인후 수정: 특히 맵뷰 어노테이션 영역 체크
 2. 복구 시 zip파일 이름 확인하기
 3.
 
 */
class MainViewController: UIViewController {

    // MARK: - Property
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var sideMenuBarButton: UIBarButtonItem!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoButton: UIButton!
    
    var mytravelSpotList: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true")
    }
    var seoulSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 1")
    }
    var gyeongGiDoSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 31")
    }
    var busanSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 6")
    }
    var gyeongNamSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 36")
    }
    var jejuSpotListDidStamp: Results<MytravelSpotObject>! {
        localRealm.objects(MytravelSpotObject.self).filter("stampStatus == true AND areaCode == 39")
    }
    var region = MyRegion.myRegion
    //여행지 데이터 2차원 배열
    let travelKorea: [[TravelData]] = [seoulTravelSpotData, gyeongGiDoTravelSpotData]
    let travelAreaCode: [Int] = [1, 6, 31, 36, 39]
    var localRealm = try! Realm()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewSetting()
        navigationConfigure()
        firstRegionAlert()
        LabelSetting()
        //최초 DB저장
        saveSpotData()
        //여행지 딕셔너리
        makeTravelSpotDictionary()
        
        backgroundImageView.isHidden = true
        
        let button = UIButton(type: .roundedRect)
          button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
          button.setTitle("Test Crash", for: [])
          button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
          view.addSubview(button)
        
    }
    
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
          let numbers = [0]
          let _ = numbers[1]
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }

    // MARK: - Method
    
    //나중에 디자인 변경에 따라 수정예정
    func navigationConfigure() {
        
//        navigationController?.navigationBar.layer.borderWidth = 1
//        navigationController?.navigationBar.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func LabelSetting() {
        
        titleLabel.text = "한국"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        percentLabel.text = "달성률: \(round(Double(mytravelSpotList.count) / Double(2090) * 1000) / 10)%"
        percentLabel.font = UIFont.systemFont(ofSize: 18)
        
        logoButton.titleLabel?.font = UIFont(name: "OTSBAggroB", size: 20)
        logoButton.isEnabled = false
    }
    
    func collectionViewSetting() {
        
        let nibName = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(nibName, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        imageCollectionView.showsHorizontalScrollIndicator = false
        imageCollectionView.isPagingEnabled = true
        
        cellLayout()
    }
    
    func saveSpotData() {
        
        saveSeoulAndGyeongGiSpotDataToDB()
        saveSpotDataToDB2(areaCode: 6, spotData: busanSpotData)
        saveSpotDataToDB2(areaCode: 36, spotData: gyeongNamSpotData)
        saveSpotDataToDB2(areaCode: 39, spotData: jejuSpotData)
    }
    
    func makeTravelSpotDictionary() {
        
        updatingDictionary(spotData: seoulTravelSpotData)
        updatingDictionary(spotData: gyeongGiDoTravelSpotData)
        updatingDictionary(spotData: busanSpotData)
        updatingDictionary(spotData: gyeongNamSpotData)
        updatingDictionary(spotData: jejuSpotData)
        
        //이후에 추가데이터들 들어오면 추가
    }
    
    //여행지데이터 디비에 쌓아주기
    
    
    @IBAction func findPlaceButtonClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TravelMapViewController") as! TravelMapViewController
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func myTravelButtonClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MytravelSpotViewController") as! MytravelSpotViewController
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func settingButtonClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func awardsButtonClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AwardsViewController") as! AwardsViewController
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav, animated: true, completion: nil)
    }
}

// MARK: - Extension

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        let row = indexPath.row
        
        cell.cellconfiguration(row: row)
        cell.backgroundColor = .white
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let page = Int(targetContentOffset.pointee.x / imageCollectionView.frame.width)
        self.pageControl.currentPage = page
        
        //타이틀 라벨 페이지에따라 바꿔주기
        switch page {
        case 0:
            titleLabel.text = "한국"
            percentLabel.text = "달성률: \(round(Double(mytravelSpotList.count) / Double(2090) * 1000) / 10)%"
            backgroundImageView.isHidden = true
        case 1:
            titleLabel.text = "서울"
            percentLabel.text = "달성률: \(round(Double(seoulSpotListDidStamp.count) / Double(255) * 1000) / 10)%"
            BackgroundConfigure(spotListDidStamp: seoulSpotListDidStamp, AllspotCount: 255, puzzleImage: "SeoulPuzzle")
//            backgroundImageView.isHidden = true
        case 2:
            titleLabel.text = "부산"
            percentLabel.text = "달성률: \(round(Double(busanSpotListDidStamp.count) / Double(119) * 1000) / 10)%"
        case 3:
            titleLabel.text = "경기도"
            percentLabel.text = "달성률: \(round(Double(gyeongGiDoSpotListDidStamp.count) / Double(708) * 1000) / 10)%"
        case 4:
            titleLabel.text = "경상남도"
            percentLabel.text = "달성률: \(round(Double(gyeongNamSpotListDidStamp.count) / Double(729) * 1000) / 10)%"
        case 5:
            titleLabel.text = "제주도"
            percentLabel.text = "달성률: \(round(Double(jejuSpotListDidStamp.count) / Double(279) * 1000) / 10)%"
        default: print("page Default")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func cellLayout() {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: imageCollectionView.bounds.height)
        layout.scrollDirection = .horizontal
        
        imageCollectionView.collectionViewLayout = layout
    }
}
/*
 구현해야하는 거
 1. 어노테이션 검색 기능(맵뷰(옵션), 나의여행지뷰, 전체여행지뷰) (해결 - 맵뷰제외하고)
 2. 다녀온 어노테이션 다른 핀이미지로 구현 (해결)
 3. 한번 다녀온 여행지 다시 갈때 얼럿 띄워주기(db에 날짜가 새로저장된다 등) (해결)
 4. 메인뷰 하단 페이지드 컨트롤 구현 (해결)
 5. 메인뷰 2번쨰 셀에 서울/경기도 퍼즐 조각 넣고 레이블 바꿔주기 (해결)
 6. 데이터 최신 순으로 쌓이게 (해결)
 7. 어노테이션뷰 이미지 밑에 타이틀 레이블 (넣으면 너무 지저분해져서 안하는걸로 결정)
 8. 마지막에 전체적으로 디자인 개선 (해결)
 9. overView 에 </br> 이런 것들 나중에 제거 처리. (해결)
 10. 콜렉션뷰 인덱스패스가 이상하게 넘어간다 해결해야함. (해결)
 11. 올트레블스팟뷰 오토레이아웃 수정
 12. 화면전환코드 좀더 다채롭게? 오른쪽에서 왼쪽으로 솩 넘어가게끔
 13. 전체 여행지뷰에서 검색할때 검색어를 여행지제목으로 딱 맞게 입력하면 검색색깔이 그대로 테이블뷰에도 적용되어버린다.(해결)
 14. 화면이 작은기기(SE 2세대, 아이폰8)에서 화면이 잘리는 현상 존재. (해결)
 15. 서울용 커스텀핀이 너무밝음 채도 좀 낮춰야함. (지역별 커스텀핀은 안하는 걸로 결정)
 16. 복구 직후 테이블뷰로 들어가면 런타임 에러 발생. -> 복구 후 종료 시키기
 
 개인정보처리방침 구현
 앱 스크린샷 구현
 사용자의 위치를 추적하기 위해서 권한이 필요합니다.
 
 오늘 구현한 거
 
 */
