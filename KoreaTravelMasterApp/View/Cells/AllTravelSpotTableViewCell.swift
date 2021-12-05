//
//  AllTravelSpotTableViewCell.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/11/27.
//

import UIKit

class AllTravelSpotTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var goToDetailButton: UIImageView!
    
    static let identifier = "AllTravelSpotTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func cellConfigure(row: MytravelSpotObject) {
        
        titleLabel.text = row.title
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func cellSearchConfigure(searchController: UISearchController, filterRow: MytravelSpotObject) {
        
        let searchBarText = searchController.searchBar.text ?? ""
        let searchTitle = NSMutableAttributedString(string: filterRow.title)
        let titleRange = (filterRow.title as NSString).range(of: searchBarText, options: .caseInsensitive)
        
        searchTitle.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 19), range: titleRange)
        
        titleLabel.attributedText = searchTitle
    }
}
