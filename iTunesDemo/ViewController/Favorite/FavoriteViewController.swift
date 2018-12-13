//
//  FavoriteViewController.swift
//  iTunesDemo
//
//  Created by Zoe.Lin on 2018/12/12.
//  Copyright © 2018 n1. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RealmSwift
import RxCocoa
import SDWebImage

class FavoriteViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: FavoriteViewModel!
    
    override convenience init(service: Service) {
        self.init(service: service, nibName: String(describing: FavoriteViewController.self))
        self.viewModel = FavoriteViewModel(realmManager: self.realmManager)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        
        self.viewModel.reloadFavoritedList = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.checkFavoritedList()
    }
}


extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: FavoriteTableViewCell.self)) as! FavoriteTableViewCell
        if self.viewModel.checkFavoritedInfoExist(index: indexPath.row) {
            let info: Favorited = self.viewModel.favoritedList[indexPath.row]
            cell.iconImageView.sd_setImage(with: URL(string: info.iconURL), completed: nil)
            cell.songNameLabel.text = info.title
            cell.singerLabel.text = info.subTitle
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.favoritedList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

