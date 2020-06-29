//
//  TabBarController.swift
//  MemeMe 2.0
//
//  Created by Marky Jordan on 6/29/20.
//  Copyright © 2020 Marky Jordan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // unhighlight unselected tab bar items
        self.tabBar.unselectedItemTintColor = .black
    }
}
