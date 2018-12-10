//
//  PlayListDetailViewController.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/10.
//  Copyright © 2018 n1. All rights reserved.
//

import UIKit
import RxSwift

class PlayListDetailViewController: BaseViewController {
    
    var tableView = UITableView()
    var disposeBag = DisposeBag()
    let id: String
    
    init(service: Service, id: String) {
        self.id = id
        super.init(service: service)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.cellIdentifier)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
}
