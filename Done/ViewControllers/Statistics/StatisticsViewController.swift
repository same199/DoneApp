//
//  StatisticsViewController.swift
//  Done
//
//  Created by LizOk&Same on 23.08.26.
//




import UIKit
import SnapKit

final class StatisticsViewController: UIViewController {

    private let navigationBar = AppNavigationBar()
    private let screenNameLabel = ScreenTitleLabel()
    private let goBackButton = BackButtons()
    private let calendarView = CalendarView()

    // Элементы Bottom Sheet
    private let overlayView = UIView()
    private let bottomSheetView = UIView()
    private let completedCountLabel = UILabel()
    private let closeButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()

        calendarView.onDayTapped = { [weak self] date in
            self?.showStatisticsBottomSheet(for: date)
        }
    }

    private func configureUI() {
        view.backgroundColor = UIColor(
            red: 244.0 / 255.0,
            green: 245.0 / 255.0,
            blue: 247.0 / 255.0,
            alpha: 1
        )

        view.addSubview(navigationBar)

        navigationBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(60)
        }

        navigationBar.addSubview(goBackButton)

        goBackButton.setTitleColor(.black, for: .normal)
        goBackButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.width.equalTo(50)
        }

        goBackButton.addTarget(
            self,
            action: #selector(backButtonTapped(_:)),
            for: .touchUpInside
        )

        navigationBar.addSubview(screenNameLabel)

        screenNameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        screenNameLabel.text = ScreenNamesTitleStrings.statisticsScreenTitle.rawValue

        view.addSubview(calendarView)

        calendarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-90)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(340)
        }
    }

    // MARK: - Bottom Sheet

    private func showStatisticsBottomSheet(for date: Date) {

        // Загружаем сохранённые активности
        let activities = ActivityStorage.shared.load()

        // Считаем завершённые активности за выбранный день
        let calendar = Calendar.current

        let completedCount = activities.filter { activity in
            guard activity.isCompleted,
                  let completedAt = activity.completedAt else {
                return false
            }

            let completionDate = Date(timeIntervalSince1970: completedAt)

            return calendar.isDate(
                completionDate,
                inSameDayAs: date
            )
        }.count

        completedCountLabel.text = "Завершенные активности: \(completedCount)"

        // Затемнение фона
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        overlayView.alpha = 0

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideStatisticsBottomSheet)
        )
        overlayView.addGestureRecognizer(tapGesture)

        view.addSubview(overlayView)

        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // Настраиваем Bottom Sheet
        bottomSheetView.backgroundColor = .white
        bottomSheetView.layer.cornerRadius = 20
        bottomSheetView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        bottomSheetView.clipsToBounds = true

        view.addSubview(bottomSheetView)

        bottomSheetView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(180)
        }

        // Кнопка закрытия
        closeButton.setImage(
            UIImage(systemName: "xmark"),
            for: .normal
        )
        closeButton.tintColor = .black
        closeButton.backgroundColor = .clear

        closeButton.addTarget(
            self,
            action: #selector(hideStatisticsBottomSheet),
            for: .touchUpInside
        )

        bottomSheetView.addSubview(closeButton)

        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(24)
        }

        // Текст с количеством завершённых активностей
        completedCountLabel.font = .systemFont(
            ofSize: 18,
            weight: .semibold
        )
        completedCountLabel.textColor = .black
        completedCountLabel.textAlignment = .center
        completedCountLabel.numberOfLines = 0

        bottomSheetView.addSubview(completedCountLabel)

        completedCountLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }

        // Анимация появления
        bottomSheetView.transform = CGAffineTransform(
            translationX: 0,
            y: 180
        )

        UIView.animate(withDuration: 0.3) {
            self.overlayView.alpha = 1
            self.bottomSheetView.transform = .identity
        }
    }

    @objc private func hideStatisticsBottomSheet() {
        UIView.animate(withDuration: 0.3, animations: {
            self.overlayView.alpha = 0
            self.bottomSheetView.transform = CGAffineTransform(
                translationX: 0,
                y: 180
            )
        }, completion: { _ in
            self.overlayView.removeFromSuperview()
            self.bottomSheetView.removeFromSuperview()
            self.bottomSheetView.transform = .identity
        })
    }

    // MARK: - Navigation

    private func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func backButtonTapped(_ sender: UIButton) {
        goBack()
    }
}



