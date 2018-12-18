//
//  PlayListDetailViewController.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/10.
//  Copyright © 2018 n1. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift
import RxRealmDataSources
import RxCocoa
import SDWebImage

class PlayListDetailViewController: BaseViewController, UITableViewDelegate {
    
    var tableView = UITableView()
    var disposeBag = DisposeBag()
    let id: String
    
    deinit {
        print("!23123")
    }
    
    private let dataSource = RxTableViewRealmDataSource<Track>( cellIdentifier: "ListTableViewCell", cellType: ListTableViewCell.self) { (cell, ip, track) in
        cell.item = track
        if let url = track.album.images.first?.url {
            cell.iconImageView.sd_setImage(with: URL.init(string: url)!, completed: nil)
        }
    }
    
    init(service: Service, id: String) {
        self.id = id
        super.init(service: service)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(UINib.init(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        self.tableView.rx.itemSelected.map { [weak self] indexPath in
            return self!.dataSource.model(at: indexPath)
            }.subscribe(onNext: { [weak self] (track) in
                let trackViewController = TrackViewController(service: self!.service, track: track)
                self?.navigationController?.pushViewController(trackViewController, animated: true)
            }).disposed(by: disposeBag)
        
        self.query()
    }
    
    private func query() {
        self.APIService.getPlaylist(id: self.id).flatMap { [weak self] (tracks) -> ObservableChangeSet<Track> in
            self?.realmManager.add(tracks)
            return self!.realmManager.queryChangeSet(type: Track.self)
        }.bind(to: self.tableView.rx.realmChanges(self.dataSource)).disposed(by: self.disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
