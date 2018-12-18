//
//  PlaylistViewController.swift
//  iTunesDemo
//
//  Created by Zoe.Lin on 2018/12/6.
//  Copyright © 2018 n1. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RealmSwift
import RxCocoa
import SDWebImage
import RxRealmDataSources

class PlaylistViewController: BaseViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var disposeBag = DisposeBag()
    
    private let dataSource = RxTableViewRealmDataSource<PlayList>( cellIdentifier: "PlaylistTableViewCell", cellType: ListTableViewCell.self) { (cell, ip, element) in
        cell.item = element
        cell.iconImageView.sd_setImage(with: URL(string: element.images.first!.url)!, completed: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.query()
    }
    
    private func query() {
        self.APIService.getPlaylists().flatMap { (playlists) -> ObservableChangeSet<PlayList> in
            self.realmManager.add(playlists)
            return self.realmManager.queryChangeSet(type: PlayList.self)
        }.bind(to: self.tableView.rx.realmChanges(self.dataSource)).disposed(by: self.disposeBag)
    }
    
    override convenience init(service: Service) {
        self.init(service: service, nibName: "PlaylistViewController")
    }
    
    private func initView() {
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.tableView.register(UINib.init(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "PlaylistTableViewCell")
        self.tableView.rx.itemSelected.map { indexPath in
            return self.dataSource.model(at: indexPath)
            }.subscribe(onNext: { (playlist) in
                let playlistDetailViewController = PlayListDetailViewController(service: self.service, id: playlist.id)
                self.navigationController?.pushViewController(playlistDetailViewController, animated: true)
            }).disposed(by: disposeBag)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
