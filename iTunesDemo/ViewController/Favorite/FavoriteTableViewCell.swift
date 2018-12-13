//
//  FavoriteTableViewCell.swift
//  iTunesDemo
//
//  Created by Zoe.Lin on 2018/12/12.
//  Copyright © 2018 n1. All rights reserved.
//

import UIKit

protocol FavoriteSongProtocol: AnyObject {
    var id: String { get set }
    var name: String { get set }
    var xxx: String { get set }
}

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    
    var item: FavoriteSongProtocol? {
        didSet {
            if let item = self.item {
                self.songNameLabel.text = item.name
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
