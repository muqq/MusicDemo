//
//  BaseViewController.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/4.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var service: Service!
    
    var APIService: APIService {
        return self.service.APIService
    }
    
    init(service: Service) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    
    init(service: Service, nibName: String) {
        self.service = service
        super.init(nibName: nibName, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
}
