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
        backgroundColor = .white
        layer.borderWidth = 1
        setTitleColor(.black, for: .normal)
        titleLabel?.font = AppTypography.button
        layer.cornerRadius = 12
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
        
        backgroundColor = .white
        setTitleColor(.white, for: .normal)
        titleLabel?.font = AppTypography.button
        layer.cornerRadius = 16
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
