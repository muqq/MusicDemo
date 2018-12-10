//
//  PlaylistTableViewCell.swift
//  iTunesDemo
//
//  Created by Zoe.Lin on 2018/12/6.
//  Copyright © 2018 n1. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class PlaylistTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var playList: PlayList? {
        didSet {
            if let playList = self.playList {
                if let url = playList.images?.first?.url {
                    self.iconImageView.sd_setImage(with: URL.init(string: url), completed: nil)
                }
                self.titleLabel.text = playList.title
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
