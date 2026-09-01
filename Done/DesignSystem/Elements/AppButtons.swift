//
//  AppButtons.swift
//  Done
//
//  Created by LizOk&Same on 1.09.26.
//
import UIKit


final class AppButtons: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        backgroundColor = .blue

        setTitleColor(.white, for: .normal)

        titleLabel?.font = AppTypography.button

        layer.cornerRadius = 12
    }
}
