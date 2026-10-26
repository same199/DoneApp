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
        backgroundColor = UIColor(
            red: 244.0 / 255.0,
            green: 245.0 / 255.0,
            blue: 247.0 / 255.0,
            alpha: 1
        )

        layer.borderWidth = 0
        layer.cornerRadius = 16
        clipsToBounds = true

        setTitleColor(.black, for: .normal)

        titleLabel?.font = .systemFont(
            ofSize: 18,
            weight: .semibold
        )
    }
}

final class BackButtons: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = .clear
        setTitleColor(.white, for: .normal)
        titleLabel?.font = AppTypography.button
        setImage(UIImage(systemName: "arrow.backward"),
                 for: .normal
        )
        tintColor = .black
    }
}

final class AddTaskButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .white
        setTitleColor(.black, for: .normal)
        titleLabel?.font = AppTypography.button
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.width / 2
    }
}

final class CloseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        setImage( UIImage( systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration( pointSize: 18, weight: .medium ) ), for: .normal )
        tintColor = .black
        backgroundColor = .clear
    }
}

final class LogoutButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .white
        setTitleColor(.black, for: .normal)
        titleLabel?.font = AppTypography.button
        layer.cornerRadius = 12

        setImage(
            UIImage(
                systemName: "rectangle.portrait.and.arrow.right"
            ),
            for: .normal
        )

        tintColor = .black
    }
}


