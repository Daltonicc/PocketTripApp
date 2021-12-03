//
//  MytravelSpotTabelViewCell.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/25.
//

import UIKit
import RealmSwift
import Kingfisher

class MytravelSpotTabelViewCell: UITableViewCell {
    
    @IBOutlet var spotImageView: UIImageView!
    @IBOutlet var spotTitleLabel: UILabel!
    @IBOutlet var getDateLabel: UILabel!
    
    static let identifier = "MytravelSpotTabelViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func cellconfigure(row: MytravelSpotObject) {
        
        let imageURL = URL(string: row.image)
        if imageURL != nil {
            spotImageView.kf.setImage(with: imageURL)
        } else {
            spotImageView.image = UIImage(named: "defaultImage")
        }
        spotImageView.layer.cornerRadius = 5
        
        spotTitleLabel.text = row.title
        spotTitleLabel.adjustsFontSizeToFitWidth = true
        spotTitleLabel.font = UIFont.systemFont(ofSize: 18)
        
        getDateLabel.text = dateFormatting(date: row.date)
    }
    
    func dateFormatting(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        dateFormatter.locale = .init(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
    
    func cellSearchConfigure(searchController: UISearchController, filterRow: MytravelSpotObject) {
        
        let searchBarText = searchController.searchBar.text ?? ""
        let searchTitle = NSMutableAttributedString(string: filterRow.title)
        let titleRange = (filterRow.title as NSString).range(of: searchBarText, options: .caseInsensitive)
        
        searchTitle.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 19), range: titleRange)
        
        spotTitleLabel.attributedText = searchTitle
    }

}
