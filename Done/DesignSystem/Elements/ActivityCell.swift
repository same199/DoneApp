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
    private let descriptionLabel = UILabel()
    private let checkboxButton = UIButton(type: .system)

    var onCheckboxTapped: (() -> Void)?
    var onLongPress: (() -> Void)?

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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onCheckboxTapped = nil
        onLongPress = nil
    }

    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 16
        cardView.clipsToBounds = true

        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail

        descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.textColor = UIColor(
            red: 140.0 / 255.0,
            green: 145.0 / 255.0,
            blue: 153.0 / 255.0,
            alpha: 1
        )
        descriptionLabel.numberOfLines = 1
        descriptionLabel.lineBreakMode = .byTruncatingTail

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
        let longPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPress(_:))
        )

        longPress.minimumPressDuration = 0.6
        cardView.addGestureRecognizer(longPress)

        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(descriptionLabel)
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
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualTo(checkboxButton.snp.leading).offset(-12)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualTo(checkboxButton.snp.leading).offset(-12)
            make.bottom.equalToSuperview().inset(12)
        }

        checkboxButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(22)
        }
    }

    func configure(with activity: Activity) {
        descriptionLabel.text = activity.description

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

    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else {
            return
        }

        onLongPress?()
    }
    
    @objc private func checkboxTapped() {
        onCheckboxTapped?()
    }
}


