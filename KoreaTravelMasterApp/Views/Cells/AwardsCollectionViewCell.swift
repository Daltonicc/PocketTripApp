//
//  AwardsCollectionViewCell.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/12/03.
//

import UIKit

class AwardsCollectionViewCell: UICollectionViewCell {
 
    static let identifier = "AwardsCollectionViewCell"

    @IBOutlet weak var awardsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
