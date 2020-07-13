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
    
    // this property allows for access and editing of the shared data model
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
//    // this computed property accesses the shared data model
//    var memes: [Meme]! {
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        return appDelegate.memes
//    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK - Life Cycle
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        // register cell
        collectionView!.register(SentMemesCollectionViewCell.self, forCellWithReuseIdentifier: "SentMemesCollectionViewCell")

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
        
        // set the placeholder view if there is no meme data to show
        if appDelegate.memes.count == 0 {
            setEmptyView(title: "No Memes Stored", message: "Tap '+' to create a new meme!")
        } else {
            restoreCollectionView()
        }
        return appDelegate.memes.count
    }

    // displays an empty placeholder view
    func setEmptyView(title: String, message: String) {

        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        messageLabel.textColor = .darkGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 10)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)

        // set constraints for empty view
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 10).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -10).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        titleLabel.numberOfLines = 0
        messageLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        messageLabel.textAlignment = .center
        
        collectionView.backgroundView = emptyView
        navigationItem.leftBarButtonItem = nil
    }
   
    // restores collection view if meme data exists
    func restoreCollectionView() {
       
        collectionView.backgroundView = nil
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // dequeue a reusable cell and get the meme object at the specified index path
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCollectionViewCell", for: indexPath) as! SentMemesCollectionViewCell
        let meme: Meme = appDelegate.memes[(indexPath as NSIndexPath).row]
    
        // set the image
        cell.cellImageView.image = meme.memedImage
        
        return cell
    }

    // MARK: - UICollection View Delegate Methods
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        // populate the view controller with data from the selected item
        detailController.memeToPresent = appDelegate.memes[(indexPath as NSIndexPath).row]
        
        // present the view controller using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
