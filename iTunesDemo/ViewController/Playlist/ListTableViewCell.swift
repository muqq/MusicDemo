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
import RealmSwift

protocol ListItemProtocol: AnyObject {
    var id: String { get set }
    var name: String { get set }
    var images: List<Image>? { get set }
}

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var item: ListItemProtocol? {
        didSet {
            if let item = self.item {
                if let url = item.images?.first?.url {
                    self.iconImageView.sd_setImage(with: URL.init(string: url), completed: nil)
                }
                self.titleLabel.text = item.name
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
