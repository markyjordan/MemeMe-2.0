//
//  TabBarController.swift
//  MemeMe 2.0
//
//  Created by Marky Jordan on 6/29/20.
//  Copyright © 2020 Marky Jordan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // unhighlight unselected tab bar items
        self.tabBar.unselectedItemTintColor = .darkGray
    }
}
