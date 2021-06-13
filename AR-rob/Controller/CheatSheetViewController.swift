//
//  CheatSheetViewController.swift
//  AR-rob
//
//  Created by Arya Ilham on 10/06/21.
//

import UIKit

class CheatSheetViewController: UIViewController, UICollectionViewDelegate {
    
    
    @IBOutlet weak var cheatSheetCollectionView: UICollectionView!
    
    var cheatSheetMaterial:[CheatSheetMaterial] = CheatSheetMaterial.getMaterial()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cheatSheetCollectionView.delegate = self
        cheatSheetCollectionView.dataSource = self
        
        let nib = UINib(nibName: "\(CheatSheetCollectionViewCell.self)", bundle: nil)
        cheatSheetCollectionView.register(nib, forCellWithReuseIdentifier: "CheatSheetCell")
    }
}

extension CheatSheetViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cheatSheetMaterial.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheatSheetCell", for: indexPath) as! CheatSheetCollectionViewCell
            
        cell.cheatTitle.text = "\(cheatSheetMaterial[indexPath.row].materialName)"
        cell.cheatSubTitle1.text = "\(cheatSheetMaterial[indexPath.row].materialSubTitle1)"
        cell.cheatSubTitle2.text = "\(cheatSheetMaterial[indexPath.row].materialSubTitle2)"
        cell.cheatDetail.text = "\(cheatSheetMaterial[indexPath.row].materialDetail)"
        cell.summaryLabel.text = "\(cheatSheetMaterial[indexPath.row].materialQuickSummary)"
        
        return cell
    }

}
//
//extension CheatSheetViewController: UICollectionViewDelegateFlowLayout{
//    
//    func collectionView(_ collectionView: UICollectionView,
//                            layout collectionViewLayout: UICollectionViewLayout,
//                            sizeForItemAt indexPath: IndexPath) -> CGSize {
//            guard let cell: CheatSheetCollectionViewCell = Bundle.main.loadNibNamed("\(CheatSheetCollectionViewCell.self)", owner: self, options: nil)?.first as? CheatSheetCollectionViewCell else {
//                return CGSize.zero
//            }
//        
//        cell.cheatTitle.text = "AAAAAAA"
//        
//            cell.setNeedsLayout()
//            cell.layoutIfNeeded()
//        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
//            return CGSize(width: 300, height: 600)
//        }
//}
