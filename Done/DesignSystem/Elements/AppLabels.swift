//
//  AppLabels.swift
//  Done
//
//  Created by LizOk&Same on 6.09.26.
//



import UIKit
import SnapKit

final class ScreenTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        font = AppTypography.title
        textColor = .black
    }
}
