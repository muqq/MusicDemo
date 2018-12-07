//
//  PlaylistViewController.swift
//  iTunesDemo
//
//  Created by Zoe.Lin on 2018/12/6.
//  Copyright © 2018 n1. All rights reserved.
//

import UIKit
import RxSwift

class PlaylistViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var disposeBag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override convenience init(service: Service) {
        self.init(service: service, nibName: "PlaylistViewController")
    }
    
    private func initView() {
        self.tableView.dequeueReusableCell(withIdentifier: "PlaylistTableViewCell")
    }

}
