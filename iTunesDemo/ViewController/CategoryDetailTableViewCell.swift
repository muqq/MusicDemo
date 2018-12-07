//
//  CategoryDetailTableViewCell.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/7.
//  Copyright © 2018 n1. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryDetailTableViewCell: UITableViewCell {

    static let cellIdentifier = "CategoryDetailTableViewCell"
    
    var playList: PlayList? {
        didSet {
            if let playList = self.playList {
                self.titleLabel.text = playList.title
                if let url = playList.images?.first?.url {
                    self.backgroundImageView.sd_setImage(with: URL.init(string: url)!, completed: nil)
                }
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
