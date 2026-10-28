//
//  AppTextFields.swift
//  Done
//
//  Created by LizOk&Same on 1.09.26.
//


import UIKit


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
        borderStyle = .none
        font = AppTypography.body
        backgroundColor = UIColor(
            red: 244.0 / 255.0,
            green: 245.0 / 255.0,
            blue: 247.0 / 255.0,
            alpha: 1
        )

        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(
            red: 230.0 / 255.0,
            green: 232.0 / 255.0,
            blue: 236.0 / 255.0,
            alpha: 1
        ).cgColor

        clipsToBounds = true
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14, dy: 0)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14, dy: 0)
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
        borderStyle = .none
        font = AppTypography.body
        backgroundColor = UIColor(
            red: 244.0 / 255.0,
            green: 245.0 / 255.0,
            blue: 247.0 / 255.0,
            alpha: 1
        )

        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(
            red: 230.0 / 255.0,
            green: 232.0 / 255.0,
            blue: 236.0 / 255.0,
            alpha: 1
        ).cgColor

        clipsToBounds = true
        isSecureTextEntry = true
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14, dy: 0)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14, dy: 0)
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
        borderStyle = .none
        font = AppTypography.body
        backgroundColor = UIColor(
            red: 244.0 / 255.0,
            green: 245.0 / 255.0,
            blue: 247.0 / 255.0,
            alpha: 1
        )

        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(
            red: 230.0 / 255.0,
            green: 232.0 / 255.0,
            blue: 236.0 / 255.0,
            alpha: 1
        ).cgColor

        clipsToBounds = true
        keyboardType = .emailAddress
        autocapitalizationType = .none
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14, dy: 0)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14, dy: 0)
    }
}

