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

    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        addSubview(naverMapView)
    }
    
    override func setConstraints() {
        naverMapView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalToSuperview()
        }
    }
    

}
