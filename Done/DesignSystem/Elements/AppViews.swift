//
//  AppViews.swift
//  Done
//
//  Created by LizOk&Same on 6.09.26.
//

import UIKit
import SnapKit


final class AddTaskView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let collapsedSize: CGFloat = 56
        static let cornerRadius: CGFloat = 28

        static let expandedCornerRadius: CGFloat = 20
    }

    // MARK: - UI

    private let addButton = AddTaskButton()

    private let titleTextField = UITextField()

    private let saveButton = UIButton()

    private var titleTextFieldTrailingConstraint: Constraint?

    // MARK: - State

    private var isExpanded = false

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

        // MARK: Add button

        addButton.setImage(
            UIImage(systemName: "plus"),
            for: .normal
        )

        addButton.tintColor = .black

        addButton.addTarget(
            self,
            action: #selector(addButtonTapped),
            for: .touchUpInside
        )

        // MARK: Title text field

        titleTextField.placeholder = "Название цели"

        titleTextField.borderStyle = .roundedRect

        titleTextField.alpha = 0

        // MARK: Save button

        saveButton.setTitle(
            "Добавить",
            for: .normal
        )

        saveButton.setTitleColor(
            .black,
            for: .normal
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

        saveButton.snp.makeConstraints { make in

            make.bottom.trailing
                .equalToSuperview()
                .inset(20)
        }
    }

    // MARK: - Actions

    @objc private func addButtonTapped() {

        if isExpanded {
            collapse()
        } else {
            expand()
        }
    }

    @objc private func saveButtonTapped() {
        let title = titleTextField.text ?? ""
        delegate?.addTaskView(
            self,
            didTapSaveWith: title
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



