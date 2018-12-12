//
//  TrackViewController.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/11.
//  Copyright © 2018 n1. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift

class TrackViewController: BaseViewController {

    @IBOutlet weak var favoriteButton: FavoriteButton!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackLabel: UILabel!
    private var track: Track!
    private var viewModel: TrackViewModel!
    private var disposeBag = DisposeBag()
    
    convenience init(service: Service, track: Track) {
        self.init(service: service, nibName: "TrackViewController")
        self.track = track
        self.viewModel = TrackViewModel.init(track: track, realmManager: self.service.realmManager)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.saveStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.trackLabel.text = self.track.name
        self.artistLabel.text = self.track.album.artist.name
        self.albumLabel.text = self.track.album.name
        if let url = self.track.album.images.first?.url {
            self.trackImageView.sd_setImage(with: URL.init(string: url)!, completed: nil)
        }

        self.viewModel.isFavortied.asObserver().bind(to: self.favoriteButton.rx.isSelected).disposed(by: self.disposeBag)
        
        self.favoriteButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { [weak self] in
            self?.viewModel.updateFavorite(isFavorite: self!.favoriteButton.isSelected)
        }).disposed(by: self.disposeBag)
        
        self.viewModel.checkTrackIsFavorited()
    }
}
