//
//  AwardsViewController+CollectionView.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2021/12/03.
//

import UIKit

extension AwardsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = awardsCollectionView.dequeueReusableCell(withReuseIdentifier: AwardsCollectionViewCell.identifier, for: indexPath) as? AwardsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.awardsImageView.backgroundColor = .blue
        
        return cell
    }
}
