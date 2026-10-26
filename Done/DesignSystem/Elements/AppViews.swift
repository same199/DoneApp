//
//  AppViews.swift
//  Done
//
//  Created by LizOk&Same on 6.09.26.
//

import UIKit
import SnapKit


final class AddTaskView: UIView {


    private enum Constants {
        static let collapsedSize: CGFloat = 56
        static let cornerRadius: CGFloat = 28

        static let expandedCornerRadius: CGFloat = 20
    }

    private let addButton = AddTaskButton()

    private let titleTextField = UITextField()
    private let descriptionTextField = UITextField()

    private let saveButton = UIButton()

    private var titleTextFieldTrailingConstraint: Constraint?

    // MARK: - State

    private var isExpanded = false
    private var isDescriptionVisible = false

    // MARK: - Delegate

    weak var delegate: AddTaskViewDelegate?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupUI()
        setupConstraints()
    }

    // MARK: - Setup

    private func setupUI() {

        backgroundColor = .white
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true

//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.08
//        layer.shadowRadius = 12
//        layer.shadowOffset = CGSize(width: 0, height: 4)
//        layer.masksToBounds = false
        // MARK: Add button

        addButton.setImage(
            UIImage(systemName: "plus"),
            for: .normal
        )

        addButton.tintColor = .white
        addButton.backgroundColor = UIColor(
            red: 57.0 / 255.0,
            green: 117.0 / 255.0,
            blue: 215.0 / 255.0,
            alpha: 1
        )

        addButton.layer.cornerRadius = 28
        addButton.addTarget(
            self,
            action: #selector(addButtonTapped),
            for: .touchUpInside
        )

        // MARK: Title text field

        titleTextField.placeholder = "Название цели"
        titleTextField.borderStyle = .roundedRect
        titleTextField.alpha = 0
        titleTextField.addTarget(
            self,
            action: #selector(titleTextFieldDidChange),
            for: .editingChanged
        )
        
        descriptionTextField.placeholder = "Описание"
        descriptionTextField.borderStyle = .roundedRect
        descriptionTextField.alpha = 0
        titleTextField.backgroundColor = UIColor(
            red: 244.0 / 255.0,
            green: 245.0 / 255.0,
            blue: 247.0 / 255.0,
            alpha: 1
        )

        descriptionTextField.backgroundColor = titleTextField.backgroundColor

        titleTextField.layer.cornerRadius = 12
        descriptionTextField.layer.cornerRadius = 12

        titleTextField.layer.borderWidth = 0
        descriptionTextField.layer.borderWidth = 0

        titleTextField.font = .systemFont(ofSize: 16)
        descriptionTextField.font = .systemFont(ofSize: 16)

        // MARK: Save button

        saveButton.setTitle(
            "Добавить",
            for: .normal
        )

        saveButton.setTitleColor(
            UIColor(
                red: 57.0 / 255.0,
                green: 117.0 / 255.0,
                blue: 215.0 / 255.0,
                alpha: 1
            ),
            for: .normal
        )

        saveButton.titleLabel?.font = .systemFont(
            ofSize: 16,
            weight: .semibold
        )

        saveButton.alpha = 0

        saveButton.addTarget(
            self,
            action: #selector(saveButtonTapped),
            for: .touchUpInside
        )

        // MARK: Add subviews

        addSubview(addButton)
        addSubview(titleTextField)
        addSubview(descriptionTextField)
        addSubview(saveButton)
    }

    private func setupConstraints() {

        addButton.snp.makeConstraints { make in

            make.center.equalToSuperview()

            make.size.equalTo(Constants.collapsedSize)
        }

        titleTextField.snp.makeConstraints { make in

            make.top.equalToSuperview().inset(24)

            make.leading.equalToSuperview().inset(20)

            make.height.equalTo(44)

            titleTextFieldTrailingConstraint =
                make.trailing
                    .equalToSuperview()
                    .offset(-20)
                    .constraint
        }
        
        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }

        saveButton.snp.makeConstraints { make in

            make.bottom.trailing
                .equalToSuperview()
                .inset(20)
        }
    }

    // MARK: - Actions
    @objc private func titleTextFieldDidChange() {
        let hasText = !(titleTextField.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty

        guard hasText != isDescriptionVisible else {
            return
        }

        isDescriptionVisible = hasText

        delegate?.addTaskViewDidChangeDescriptionState(
            self,
            isVisible: hasText
        )

        UIView.animate(withDuration: 0.25) {
            self.descriptionTextField.alpha = hasText ? 1 : 0
        }
    }

    @objc private func addButtonTapped() {

        if isExpanded {
            collapse()
        } else {
            expand()
        }
    }

    @objc private func saveButtonTapped() {
        let title = titleTextField.text ?? ""
        let description = descriptionTextField.text ?? ""

        delegate?.addTaskView(
            self,
            didTapSaveWith: title,
            description: description
        )

        collapse()
    }

    // MARK: - Public

    func expand() {
        guard !isExpanded else {
            return
        }
        isExpanded = true
        addButton.setImage(
            UIImage(systemName: "xmark"),
            for: .normal
        )

        addButton.tintColor = .black
        addButton.backgroundColor = .clear
        addButton.layer.borderWidth = 0
        addButton.snp.remakeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
            make.size.equalTo(40)
        }
        titleTextFieldTrailingConstraint?.update(
            offset: -68
        )
        delegate?.addTaskViewDidChangeState(
            self,
            isExpanded: true
        )
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: 0.5
        ) {
            self.layer.cornerRadius =
                Constants.expandedCornerRadius
            self.titleTextField.alpha = 1
            self.saveButton.alpha = 1
            self.superview?.layoutIfNeeded()
        }
    }

    func collapse() {
        guard isExpanded else {
            return
        }
        isExpanded = false
        addButton.setImage(
            UIImage(systemName: "plus"),
            for: .normal
        )

        addButton.tintColor = .white
        addButton.backgroundColor = UIColor(
            red: 57.0 / 255.0,
            green: 117.0 / 255.0,
            blue: 215.0 / 255.0,
            alpha: 1
        )
        addButton.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(Constants.collapsedSize)
        }
        titleTextFieldTrailingConstraint?.update(
            offset: -20
        )
        delegate?.addTaskViewDidChangeState(
            self,
            isExpanded: false
        )
        UIView.animate(withDuration: 0.3) {
            self.layer.cornerRadius =
                Constants.cornerRadius
            self.titleTextField.alpha = 0
            self.saveButton.alpha = 0
            self.superview?.layoutIfNeeded()
        }
    }
}



