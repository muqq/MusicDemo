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

class PlaylistViewController: BaseViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var disposeBag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, PlayList>>(
        configureCell: { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "PlaylistTableViewCell") as! ListTableViewCell
            cell.item = element
            return cell
    }, titleForHeaderInSection: { dataSource, sectionIndex in
        return dataSource[sectionIndex].model
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.query()
    }
    
    private func query() {
        let realm = AppDelegate.appDelegate().realm!
        self.APIService.getPlaylists().catchError { (error) -> Observable<[PlayList]> in
            let result = realm.objects(PlayList.self)
            return Observable<[PlayList]>.just(Array(result))
            }.map { (playLists) -> [SectionModel<String, PlayList>] in
                try! realm.write {
                    realm.add(playLists)
                }
                return [SectionModel.init(model: "PlayLists", items: playLists)]
            }.bind(to: self.tableView.rx.items(dataSource: dataSource)).disposed(by: self.disposeBag)
    }
    
    override convenience init(service: Service) {
        self.init(service: service, nibName: "PlaylistViewController")
    }
    
    private func initView() {
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.tableView.register(UINib.init(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "PlaylistTableViewCell")
        self.tableView.rx.itemSelected.map { indexPath in
            return self.dataSource[indexPath]
            }.subscribe(onNext: { (playlist) in
                let playlistDetailViewController = PlayListDetailViewController(service: self.service, id: playlist.id)
                self.navigationController?.pushViewController(playlistDetailViewController, animated: true)
            }).disposed(by: disposeBag)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
