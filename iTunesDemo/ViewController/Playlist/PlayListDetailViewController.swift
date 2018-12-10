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
import RxDataSources
import RxCocoa
import SDWebImage

class PlayListDetailViewController: BaseViewController, UITableViewDelegate {
    
    var tableView = UITableView()
    var disposeBag = DisposeBag()
    let id: String
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Track>>(
        configureCell: { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "ListTableViewCell")! as! ListTableViewCell
            cell.item = element
            if let url = element.album?.images?.first?.url {
                cell.iconImageView.sd_setImage(with: URL.init(string: url)!, completed: nil)
            }
            return cell
    }, titleForHeaderInSection: { dataSource, sectionIndex in
        return dataSource[sectionIndex].model
    })
    
    init(service: Service, id: String) {
        self.id = id
        super.init(service: service)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(UINib.init(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        self.query()
    }
    
    private func query() {
        self.APIService.getPlaylist(id: self.id).map { (tracks) -> [SectionModel<String, Track>] in
                return [SectionModel.init(model: "Tracks", items: Array(tracks.tracks.data))]
        }.bind(to: self.tableView.rx.items(dataSource: dataSource)).disposed(by: self.disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
