//
//  CalendarView.swift
//  Done
//
//  Created by LizOk&Same on 19.10.26.
//

import UIKit
import SnapKit



import UIKit
import SnapKit

final class CalendarView: UIView {

    private let monthLabel = UILabel()
    private let calendarGrid = UIStackView()
    private let previousMonthButton = UIButton(type: .system)
    private let nextMonthButton = UIButton(type: .system)
    private let monthHeader = UIStackView()

    private var currentDate = Calendar.current.date(
        from: DateComponents(year: 2026, month: 10, day: 1)
    )!

    // Передаёт выбранную дату в StatisticsViewController
    var onDayTapped: ((Date) -> Void)?

    private let weekDays = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
        configureConstraints()
        configureCalendar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 0, height: 4)

        monthLabel.text = "Октябрь 2026"
        monthLabel.font = .systemFont(ofSize: 20, weight: .bold)
        monthLabel.textAlignment = .center

        previousMonthButton.setImage(
            UIImage(systemName: "arrow.backward"),
            for: .normal
        )
        previousMonthButton.tintColor = UIColor(
            red: 90.0 / 255.0,
            green: 96.0 / 255.0,
            blue: 105.0 / 255.0,
            alpha: 1
        )

        nextMonthButton.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        nextMonthButton.tintColor = UIColor(
            red: 90.0 / 255.0,
            green: 96.0 / 255.0,
            blue: 105.0 / 255.0,
            alpha: 1
        )
        

        monthHeader.axis = .horizontal
        monthHeader.alignment = .center
        monthHeader.distribution = .fill
        monthHeader.spacing = 8

        monthHeader.addArrangedSubview(previousMonthButton)
        monthHeader.addArrangedSubview(monthLabel)
        monthHeader.addArrangedSubview(nextMonthButton)

        calendarGrid.axis = .vertical
        calendarGrid.spacing = 2
        calendarGrid.distribution = .fillEqually
        calendarGrid.alignment = .fill

        addSubview(monthHeader)
        addSubview(calendarGrid)

        previousMonthButton.addTarget(
            self,
            action: #selector(showPreviousMonth),
            for: .touchUpInside
        )

        nextMonthButton.addTarget(
            self,
            action: #selector(showNextMonth),
            for: .touchUpInside
        )
    }

    private func configureConstraints() {
        monthHeader.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(36)
        }

        previousMonthButton.snp.makeConstraints { make in
            make.width.equalTo(36)
        }

        nextMonthButton.snp.makeConstraints { make in
            make.width.equalTo(36)
        }

        monthLabel.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.greaterThanOrEqualTo(150)
        }

        calendarGrid.snp.makeConstraints { make in
            make.top.equalTo(monthHeader.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(250)
        }
    }

    @objc private func showPreviousMonth() {
        guard let date = Calendar.current.date(
            byAdding: .month,
            value: -1,
            to: currentDate
        ) else { return }

        currentDate = date
        configureCalendar()
    }

    @objc private func showNextMonth() {
        guard let date = Calendar.current.date(
            byAdding: .month,
            value: 1,
            to: currentDate
        ) else { return }

        currentDate = date
        configureCalendar()
    }

    private func configureCalendar() {

        // Удаляем предыдущие строки календаря
        for view in calendarGrid.arrangedSubviews {
            calendarGrid.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2 // Понедельник

        // Обновляем название месяца и год
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "LLLL yyyy"

        monthLabel.text = formatter.string(from: currentDate)
            .capitalized(with: formatter.locale)

        // Получаем первый день месяца
        let components = calendar.dateComponents(
            [.year, .month],
            from: currentDate
        )

        guard let firstDay = calendar.date(from: components),
              let daysRange = calendar.range(
                  of: .day,
                  in: .month,
                  for: firstDay
              ) else { return }

        let numberOfDays = daysRange.count

        // Заголовок дней недели
        let weekHeader = makeRow()

        for day in weekDays {
            let label = UILabel()
            label.text = day
            label.font = .systemFont(ofSize: 12, weight: .medium)
            label.textColor = .secondaryLabel
            label.textAlignment = .center

            weekHeader.addArrangedSubview(label)
        }

        calendarGrid.addArrangedSubview(weekHeader)

        // Определяем отступ до первого числа
        let weekday = calendar.component(.weekday, from: firstDay)
        let leadingSpaces = (weekday + 5) % 7

        let totalCells = ((leadingSpaces + numberOfDays + 6) / 7) * 7

        // Создаём строки с числами
        for rowStart in stride(from: 0, to: totalCells, by: 7) {
            let row = makeRow()

            for column in 0..<7 {
                let index = rowStart + column
                let dayNumber = index - leadingSpaces + 1

                let dayButton = UIButton(type: .system)
                dayButton.titleLabel?.textAlignment = .center

                if dayNumber >= 1 && dayNumber <= numberOfDays {

                    dayButton.setTitle("\(dayNumber)", for: .normal)

                    let displayedDate = calendar.date(
                        from: DateComponents(
                            year: calendar.component(.year, from: currentDate),
                            month: calendar.component(.month, from: currentDate),
                            day: dayNumber
                        )
                    )!

                    let today = Date()

                    let todayComponents = calendar.dateComponents(
                        [.year, .month, .day],
                        from: today
                    )

                    let isToday =
                        todayComponents.year == calendar.component(.year, from: displayedDate) &&
                        todayComponents.month == calendar.component(.month, from: displayedDate) &&
                        todayComponents.day == dayNumber

                    let isPastDay = calendar.startOfDay(for: displayedDate)
                        < calendar.startOfDay(for: today)

                    if isToday {
                        dayButton.setTitleColor(.systemBlue, for: .normal)
                        dayButton.titleLabel?.font = .systemFont(
                            ofSize: 14,
                            weight: .bold
                        )
                    } else if isPastDay {
                        dayButton.setTitleColor(.systemGray2, for: .normal)
                        dayButton.titleLabel?.font = .systemFont(
                            ofSize: 14,
                            weight: .regular
                        )
                    } else {
                        dayButton.setTitleColor(.label, for: .normal)
                        dayButton.titleLabel?.font = .systemFont(
                            ofSize: 14,
                            weight: .regular
                        )
                    }

                    // Обработка нажатия на день
                    dayButton.addAction(
                        UIAction { [weak self] _ in
                            self?.onDayTapped?(displayedDate)
                        },
                        for: .touchUpInside
                    )

                } else {
                    dayButton.setTitle(nil, for: .normal)
                    dayButton.isEnabled = false
                }

                row.addArrangedSubview(dayButton)
            }

            calendarGrid.addArrangedSubview(row)
        }
    }

    private func makeRow() -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 4
        row.distribution = .fillEqually
        row.alignment = .fill

        return row
    }
}


