//
//  FavoriteButton.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/11.
//  Copyright © 2018 n1. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setTitle("Favorite", for: .normal)
        self.setTitle("Favorited", for: .selected)
    }
}
