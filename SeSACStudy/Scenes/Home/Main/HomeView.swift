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
    var buttonConfiguration = UIButton.Configuration.plain()
    let statusButton = UIButton()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        [naverMapView, markerImageView, statusButton].forEach {
            addSubview($0)
        }
        
        naverMapView.mapView.addCameraDelegate(delegate: self)
    }
    
    override func setUI() {
        markerImageView.image = Asset.Home.Main.mapMarker.image
        
//        buttonConfiguration.image = Asset.Home.Main.Status.defaultStatus.image
//        statusButton.configuration = buttonConfiguration
    }
    
    func setStatusButtonImage(as status: Status) {
        let image: ImageAsset.Image
        switch status {
            case .standby:
                image = Asset.Home.Main.Status.matching.image
            case .matched:
                image = Asset.Home.Main.Status.matched.image
            case .defaultStatus:
                image = Asset.Home.Main.Status.defaultStatus.image
        }
        buttonConfiguration.image = image
        statusButton.configuration = buttonConfiguration
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
        
        statusButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
//    private func setActions() {
//        statusButton.addTarget(self, action: #selector(statusButtonClicked), for: .touchUpInside)
//    }
    
    // MARK: - Action Methods
//    @objc private func statusButtonClicked() {
//        findSesac()
//    }
    
    // MARK: - Networking Methods
//    private func findSesac() {
//        QueueAPIManager.find(latitude: 37.518607, longitude: 126.887520,
//                             studyList: ["anything", "Swift"]) { result in
//            switch result {
//                case .success(let success):
//                    print("🐣 스터디 함께할 친구 찾기 요청 성공")
//                case .failure(let error):
//                    if let definedError = error as? QueueAPIError {
//                        print("🐥 QueueAPIError: \(definedError)")
//                        if definedError == .firebaseTokenError {
//                            self?.refreshIDToken {
//                                self?.fetchQueueState()
//                            }
//                        }
//                        return
//                    }
//                    
//                    if let definedError = error as? QueueAPIError.MyQueueState {
//                        print("🐥 QueueAPIError.MyQueueState: \(definedError)")
//                    }
//            }
//        }
//    }
}

extension HomeView: NMFMapViewCameraDelegate {
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
//        print("🍓", #function)
//        print("🍓", mapView.cameraPosition)
    }
    
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
//        print("🍋", #function)
//        print("🍋", mapView.cameraPosition)
    }
}
