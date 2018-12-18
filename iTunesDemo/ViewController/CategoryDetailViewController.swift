//
//  CategoryDetailViewController.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/5.
//  Copyright © 2018 n1. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import RxDataSources
import SnapKit

class CategoryDetailViewController: BaseViewController, UITableViewDelegate {
    
    var tableView = UITableView()
    var disposeBag = DisposeBag()
    let id: String
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, PlayList>>(
        configureCell: { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: CategoryDetailTableViewCell.cellIdentifier)! as! CategoryDetailTableViewCell
            cell.playList = element
            return cell
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
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        self.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        self.tableView.register(UINib(nibName: "CategoryDetailTableViewCell", bundle: nil), forCellReuseIdentifier: CategoryDetailTableViewCell.cellIdentifier)
        self.APIService.getCateogry(id: self.id).catchError({ (error) -> Observable<CategoryDetail> in
            let result: Results<CategoryDetail> = self.realmManager.query()
            return Observable<CategoryDetail>.just(result.elements.first!)
        }).map { (detail) -> [SectionModel<String, PlayList>] in
            self.realmManager.add(object: detail)
            return [SectionModel(model: "PlayList", items: Array(detail.playlists!.data))]
        }.bind(to: self.tableView.rx.items(dataSource: dataSource)).disposed(by: self.disposeBag)

        self.tableView.rx.itemSelected.map { indexPath in
            return self.dataSource[indexPath]
            }.subscribe(onNext: { (playlist) in
                let playListDetailVC = PlayListDetailViewController.init(service: self.service, id: playlist.id)
                self.navigationController?.pushViewController(playListDetailVC, animated: true)
            }).disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

