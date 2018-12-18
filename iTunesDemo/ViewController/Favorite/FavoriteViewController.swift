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
import RxRealmDataSources

class FavoriteViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        print("234234234")
    }
    
    private let disposeBag = DisposeBag()
    private let dataSource = RxTableViewRealmDataSource<Favorited>( cellIdentifier: "FavoriteTableViewCell", cellType: FavoriteTableViewCell.self) { (cell, ip, favorited) in
        cell.iconImageView.sd_setImage(with: URL(string: favorited.iconURL), completed: nil)
        cell.songNameLabel.text = favorited.title
        cell.singerLabel.text = favorited.subTitle
    }
    
    override convenience init(service: Service) {
        self.init(service: service, nibName: String(describing: FavoriteViewController.self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        self.realmManager.queryChangeSet(type: Favorited.self).bind(to: tableView.rx.realmChanges(self.dataSource)).disposed(by: self.disposeBag)
        
        self.tableView.rx.realmModelSelected(Favorited.self)
            .map({ [weak self] (favorited) -> Track in
                return self!.realmManager.query(type: Track.self).filter("id = %@", favorited.id).first!
            })
            .subscribe(onNext: { [weak self] (track) in
                let trackVC = TrackViewController.init(service: self!.service, track: track)
                self?.navigationController?.pushViewController(trackVC, animated: true)
            }).disposed(by: self.disposeBag)
    }

}


extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

