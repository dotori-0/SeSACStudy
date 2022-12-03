//
//  AgeRangeCollectionViewCell.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/03.
//

import UIKit
import MultiSlider

class AgeRangeCollectionViewCell: InfoManagementCollectionViewCell {
    // MARK: - Properties
    let ageRangeLabel = UILabel()
    let slider = MultiSlider()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(category: String.MyInfo.InfoManagement.ageRange)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        super.setHierarchy()
        
        [ageRangeLabel, slider].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setUI() {
        super.setUI()
        
        ageRangeLabel.textColor = Asset.Colors.BrandColor.green.color
        ageRangeLabel.font = .Title3_M14
        
        setSlider()
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        // Use updateConstraints where you have identical attribute combinations and just want to update the constant value (e.g. offset(10) to offset(20) 인데 왜 updateConstraints를 하면
        // Updated constraint could not find existing matching constraint to update 에러가 뜨는지?❔
//        categoryLabel.snp.updateConstraints { make in
////            make.centerY.equalToSuperview().multipliedBy(0.5)
////            make.height.equalToSuperview().dividedBy(5)
//            make.height.equalTo(categoryLabel.superview!).dividedBy(5)
//        }
        
        categoryLabel.snp.remakeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.5)
            make.leading.equalToSuperview()
            make.height.equalToSuperview().dividedBy(4.5)
        }
        
        ageRangeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(categoryLabel)
            make.trailing.equalToSuperview()
        }
        
        slider.snp.makeConstraints { make in
//            make.top.equalTo(contentView.snp.)
            make.centerY.equalToSuperview().multipliedBy(1.35)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
    }
    
    private func setSlider() {
        slider.minimumValue = 18
        slider.maximumValue = 65
        slider.snapStepSize = 1
        
        slider.orientation = .horizontal
//        slider.valueLabelPosition = .top
//        slider.backgroundColor = .systemYellow.withAlphaComponent(0.4)

        slider.outerTrackColor = Asset.Colors.Grayscale.gray2.color
        slider.tintColor = Asset.Colors.BrandColor.green.color // color of track
        slider.trackWidth = 4

        slider.thumbImage = Asset.MyInfo.InfoManagement.sliderThumb.image
        slider.showsThumbImageShadow = false // wide tracks look better without thumb shadow

//        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged) // continuous changes
//        slider.addTarget(self, action: #selector(sliderDragEnded(_:)), for: . touchUpInside) // sent when drag ends
    }
    
    func updateAgeRangeLabel(minAge: CGFloat, maxAge: CGFloat) {
//        ageRangeLabel.text = "\(minAge) - \(maxAge)"
        ageRangeLabel.text = "\(Int(minAge)) - \(Int(maxAge))"
    }
}
