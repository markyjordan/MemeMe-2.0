//
//  SentMemesTableViewController.swift
//  MemeMe 2.0
//
//  Created by Marky Jordan on 6/29/20.
//  Copyright © 2020 Marky Jordan. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {

    // this computed property accesses the shared data model
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        tableView!.reloadData()
    }

    // MARK: - UITableView Data Source Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeue a reusable cell and get the meme object at the specified index path
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemesTableViewCell", for: indexPath) as! SentMemesTableViewCell
        let meme: Meme = memes[(indexPath as NSIndexPath).row]
        
        // set the image and label
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topTextField + "..." + meme.bottomTextField
        
        return cell
    }
    
    // MARK: - UITableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        // populate the view controller with data from the selected item
        detailController.memeToPresent = memes[(indexPath as NSIndexPath).row]
        
        // present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
    }
}
