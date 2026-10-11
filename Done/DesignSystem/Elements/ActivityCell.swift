//
//  AppCell.swift
//  Done
//
//  Created by LizOk&Same on 11.10.26.
//




import UIKit
import SnapKit

final class ActivityCell: UITableViewCell {

    static let reuseIdentifier = "ActivityCell"

    private let cardView = UIView()
    private let titleLabel = UILabel()
    private let checkboxPlaceholder = UIView()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 16
        cardView.clipsToBounds = true

        titleLabel.font = .systemFont(
            ofSize: 16,
            weight: .medium
        )
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2

        // Пока это только место под будущий чекбокс.
        checkboxPlaceholder.layer.borderWidth = 1.5
        checkboxPlaceholder.layer.borderColor =
            UIColor.lightGray.cgColor
        checkboxPlaceholder.layer.cornerRadius = 11

        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(checkboxPlaceholder)
    }

    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
            make.height.greaterThanOrEqualTo(64)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(12)
            make.trailing.lessThanOrEqualTo(
                checkboxPlaceholder.snp.leading
            ).offset(-12)
        }

        checkboxPlaceholder.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(22)
        }
    }

    func configure(with activity: Activity) {
        titleLabel.text = activity.title
    }
}
