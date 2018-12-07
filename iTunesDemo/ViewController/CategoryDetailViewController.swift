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

class CateogryDetailViewController: BaseViewController {
    
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
        self.APIService.getCateogry(id: self.id).subscribe(onNext: { (detail) in
            print(detail)
        }, onError: { error in
            print(error)
        }).disposed(by: self.disposeBag)
    }
}
