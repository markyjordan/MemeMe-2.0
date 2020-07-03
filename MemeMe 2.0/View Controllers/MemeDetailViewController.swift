//
//  MemeDetailViewController.swift
//  MemeMe 2.0
//
//  Created by Marky Jordan on 6/29/20.
//  Copyright © 2020 Marky Jordan. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    var memeToPresent: Meme!
    
    @IBOutlet memeImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        memeImageView.image = memeToPresent.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
