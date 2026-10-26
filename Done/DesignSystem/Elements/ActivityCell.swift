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
    private let checkboxButton = UIButton(type: .system)

    var onCheckboxTapped: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2

        checkboxButton.layer.borderWidth = 1.5
        checkboxButton.layer.borderColor = UIColor.lightGray.cgColor
        checkboxButton.layer.cornerRadius = 11
        checkboxButton.tintColor = .white

        let checkmark = UIImage(systemName: "checkmark.circle")?
            .withConfiguration(
                UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
            )

        checkboxButton.setImage(checkmark, for: .normal)
        checkboxButton.imageView?.contentMode = .scaleAspectFit

        checkboxButton.addTarget(
            self,
            action: #selector(checkboxTapped),
            for: .touchUpInside
        )

        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(checkboxButton)
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
            make.trailing.lessThanOrEqualTo(checkboxButton.snp.leading).offset(-12)
        }

        checkboxButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(22)
        }
    }

    func configure(with activity: Activity) {
        if activity.isCompleted {
            checkboxButton.setImage(
                UIImage(systemName: "checkmark.circle"),
                for: .normal
            )
            checkboxButton.backgroundColor = .systemBlue
            checkboxButton.layer.borderColor = UIColor.systemBlue.cgColor
            checkboxButton.tintColor = .white

            titleLabel.attributedText = NSAttributedString(
                string: activity.title,
                attributes: [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .foregroundColor: UIColor.systemGray3
                ]
            )
        } else {
            checkboxButton.setImage(nil, for: .normal)
            checkboxButton.backgroundColor = .clear
            checkboxButton.layer.borderColor = UIColor.lightGray.cgColor
            checkboxButton.tintColor = .white

            titleLabel.attributedText = nil
            titleLabel.text = activity.title
            titleLabel.textColor = .black
        }
    }

    @objc private func checkboxTapped() {
        onCheckboxTapped?()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onCheckboxTapped = nil
    }
}


