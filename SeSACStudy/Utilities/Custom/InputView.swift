//
//  InputView.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/11.
//

import UIKit

import RxCocoa
import RxSwift

class InputView: BaseView {
    // MARK: - Properties
    private var isNumberPad: Bool?
    private var allowsSelection: Bool?
    
    var textField = NoActionTextField()
//    let textField = UITextField()
    private let bottomLineView = UIView()
    var isTextFieldFocused: Bool {
        didSet {
            print("didSet")
            setBottomLineView()
        }
    }
    let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    init(placeholder: String = "",
         isNumberPad: Bool = true,
         allowsSelection: Bool = true) {
        self.isNumberPad = isNumberPad
        self.allowsSelection = allowsSelection
        isTextFieldFocused = false  // 이걸로는 didSet이 호출되지 않는다 ❔
        super.init(frame: .zero)
        setPlaceholder(as: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        [textField, bottomLineView].forEach {
            addSubview($0)
        }
    }
    
    override func setUI() {
        setTextField()
        setBottomLineView()
    }
    
    override func setConstraints() {
        bottomLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.bottom.equalTo(bottomLineView.snp.top)
            make.width.top.equalToSuperview()
        }
    }
    
    // MARK: - Design Methods
    private func setTextField() {
        guard let isNumberPad else { return }
        textField.keyboardType = isNumberPad ? .numberPad : .default
        
        if let allowsSelection, !allowsSelection {
            textField = NoSelectionTextField()
            addSubview(textField)  // 다시 addSubview 해야하는 이유와 기존 객체를 removeFromSuperview() 하지 않아도 되는지? ❔
        }
        
        textField.borderStyle = .none
        textField.font = .Title4_R14
        textField.textColor = Asset.Colors.BlackWhite.black.color
        
        setFocusState()
        addInset()
    }
    
    
    private func setFocusState() {
        textField.rx.controlEvent(.editingDidBegin)
            .asDriver()
            .drive(with: self) { view, _ in
                view.isTextFieldFocused = true
            }
            .disposed(by: disposeBag)
            
        textField.rx.controlEvent(.editingDidEnd)
            .asDriver()
            .drive(with: self) { view, _ in
                view.isTextFieldFocused = false
            }
            .disposed(by: disposeBag)
    }
    
    private func addInset() {
        let insetView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        textField.leftView = insetView
        textField.leftViewMode = .always
    }
    
    func setPlaceholder(as placeholder: String) {
//        textField.placeholder = placeholder
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: [.font: UIFont.Title4_R14,
                                                                          .foregroundColor: Asset.Colors.Grayscale.gray7.color])
    }
    
    private func setBottomLineView() {
        print(#function)
        var bottomLineColor: ColorAsset = isTextFieldFocused ? Asset.Colors.SystemColor.focus : Asset.Colors.Grayscale.gray3
        
        if let allowsSelection, !allowsSelection {
            bottomLineColor = Asset.Colors.Grayscale.gray3
        }
        
        bottomLineView.backgroundColor = bottomLineColor.color
    }
}
