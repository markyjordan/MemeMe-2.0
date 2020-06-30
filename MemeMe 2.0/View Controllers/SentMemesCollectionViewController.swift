//
//  SentMemesCollectionViewController.swift
//  MemeMe 2.0
//
//  Created by Marky Jordan on 6/29/20.
//  Copyright © 2020 Marky Jordan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SentMemesCollectionViewCell"

class SentMemesCollectionViewController: UICollectionViewController {
    
    // this computed property accesses the shared data model
    var memes: [Meme]! {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK - Life Cycle
    
    override func viewDidLoad() {
       
        super.viewDidLoad()

        // register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // flow layout setup
        let space: CGFloat = 3.0
        let cellWidth = (view.frame.size.width - (2 * space)) / 3.0
        let cellHeight = (view.frame.size.height - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // refresh the collection view to show current meme data
        collectionView!.reloadData()
    }

    // MARK: - UICollectionView Data Source Methods

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: - UICollection View Delegate Methods
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
}
