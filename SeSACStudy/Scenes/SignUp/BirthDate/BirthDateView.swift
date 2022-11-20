//
//  BirthDateView.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/19.
//

import UIKit

class BirthDateView: VerificationAndSignUpView {
    // MARK: - Properties
    let yearInputView = InputView(allowsSelection: false)
    let yearLabel = SignUpLabel(text: String.BirthDate.year)
    let yearStackView = UIStackView()
//    let yearStackView = UIView()
    
    let monthInputView = InputView(allowsSelection: false)
    let monthLabel = SignUpLabel(text: String.BirthDate.month)
    let monthStackView = UIStackView()
    
    let dayInputView = InputView(allowsSelection: false)
    let dayLabel = SignUpLabel(text: String.BirthDate.day)
    let dayStackView = UIStackView()
    
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 23
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    let datePicker = UIDatePicker()
    
    // MARK: - Setting Methods
    override func setUI() {
        super.setText(labelText: String.BirthDate.inputBirthDate,
                      textFieldPlaceholder: "",
                      buttonTitle: String.Action.next)
        
        setStackViews()
        setDatePicker()
        setPlaceholders()
        
//        [yearInputView, monthInputView, dayInputView].forEach { view in
//            view.backgroundColor = .systemPink
//        }
        
        [yearLabel, monthLabel, dayLabel].forEach { view in
//            view.backgroundColor = .systemYellow
            view.setContentHuggingPriority(. required, for: .horizontal)
        }
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        [yearInputView, yearLabel].forEach { yearStackView.addArrangedSubview($0) }
        [monthInputView, monthLabel].forEach { monthStackView.addArrangedSubview($0) }
        [dayInputView, dayLabel].forEach { dayStackView.addArrangedSubview($0) }
        
        [yearStackView, monthStackView, dayStackView].forEach { stackView.addArrangedSubview($0) }
        
        addSubview(stackView)
    }
    
    
    override func setConstraints() {
        super.setConstraints()

        stackView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(80)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        userInputView.removeFromSuperview()
    }
    
    override func updateInitialConstraints() {
        button.snp.makeConstraints { make in  // remake 하지 않아도 되는 이유? ❔
            make.top.equalTo(stackView.snp.bottom).offset(72)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
    private func setStackViews() {
        [yearStackView, monthStackView, dayStackView].forEach {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.alignment = .center
            $0.distribution = .fillProportionally
        }
    }
    
    private func setDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        let minimumDate = DateComponents(calendar: .current, year: 1900, month: 1, day: 1).date
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = Date.now
        
        guard let defaultDate = DateComponents(calendar: .current, year: 1990, month: 1, day: 1).date else { return }
        datePicker.date = defaultDate
        
        [yearInputView, monthInputView, dayInputView].forEach {
            $0.textField.inputView = datePicker
        }
    }
    
    private func setPlaceholders() {
//        datePicker.date.
        yearInputView.setPlaceholder(as: "1990")
        monthInputView.setPlaceholder(as: "1")
        dayInputView.setPlaceholder(as: "1")
    }
}
