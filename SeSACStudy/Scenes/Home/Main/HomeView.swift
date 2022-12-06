//
//  HomeView.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/06.
//

import UIKit
import NMapsMap

class HomeView: BaseView {
    // MARK: - Properties
    let naverMapView = NMFNaverMapView()
    let markerImageView = UIImageView()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        [naverMapView, markerImageView].forEach {
            addSubview($0)
        }
    }
    
    override func setUI() {
        markerImageView.image = Asset.Home.Main.mapMarker.image
    }
    
    override func setConstraints() {
        naverMapView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalToSuperview()
        }
        
        markerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(48)
            make.height.equalTo(markerImageView.snp.width)
            make.bottom.equalTo(self.snp.centerY)
        }
        
        markerImageView.isHidden = true
    }
}
