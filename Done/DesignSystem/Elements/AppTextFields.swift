//
//  AppTextFields.swift
//  Done
//
//  Created by LizOk&Same on 1.09.26.
//


import UIKit

final class AppTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        borderStyle = .roundedRect
        font = AppTypography.body
        backgroundColor = .white
    }
}

final class PasswordTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        borderStyle = .roundedRect
        font = AppTypography.body
        backgroundColor = .white
        isSecureTextEntry = true
    }
}

final class EmailTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        borderStyle = .roundedRect
        font = AppTypography.body
        backgroundColor = .white
        keyboardType = .emailAddress
        autocapitalizationType = .none
    }
}
