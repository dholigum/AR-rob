//
//  CheatSheetViewController.swift
//  AR-rob
//
//  Created by Arya Ilham on 10/06/21.
//

import UIKit

class CheatSheetViewController: UIViewController, UICollectionViewDelegate {
    
    
    @IBOutlet weak var cheatSheetCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cheatSheetCollectionView.delegate = self
        cheatSheetCollectionView.dataSource = self
    }
}

extension CheatSheetViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheatSheetCell", for: indexPath) as! CheatSheetCollectionViewCell
            
        cell.cheatTitle.text = "aaaaaaaa"
        
        return cell
    }

}
