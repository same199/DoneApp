//
//  AppNavigationBar.swift
//  Done
//
//  Created by LizOk&Same on 3.09.26.
//

import UIKit


final class AppNavigationBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 16
    }
}
