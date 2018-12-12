//
//  ViewController.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/11/27.
//  Copyright © 2018 n1. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

class CategoryViewController: BaseViewController {
    
    var tableView = UITableView()
    var disposeBag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Category>>(
        configureCell: { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: CategoryCell.cellIdentifier)!
            cell.textLabel?.text = element.title
            return cell
    }, titleForHeaderInSection: { dataSource, sectionIndex in
        return dataSource[sectionIndex].model
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.cellIdentifier)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        self.setupRX()
        self.query()
    }
    
    private func setupRX() {
        self.tableView.rx.itemSelected.map { indexPath in
            return self.dataSource[indexPath]
            }.subscribe(onNext: { (category) in
                let categoryDetailViewController = CategoryDetailViewController(service: self.service, id: category.id)
                self.navigationController?.pushViewController(categoryDetailViewController, animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func query() {
        let realm = AppDelegate.appDelegate().realm!
        self.APIService.getCateogries().catchError { (error) -> Observable<[Category]> in
            let result = realm.objects(Category.self)
            return Observable<[Category]>.just(Array(result))
            }.map { (categories) -> [SectionModel<String, Category>] in
                let _ = self.realmManager.add(categories)
                return [SectionModel.init(model: "Categories", items: categories)]
            }.bind(to: self.tableView.rx.items(dataSource: dataSource)).disposed(by: self.disposeBag)
    }
}

class CategoryCell: UITableViewCell {
    static let cellIdentifier = "categoryCell"
}

