//
//  ActivityFormViewController.swift
//  Done
//
//  Created by LizOk&Same on 23.08.26.
//



import UIKit
import SnapKit

class ActivityFormViewController: UIViewController {
    private let navigationBar = AppNavigationBar()
    private let screenNameLabel = ScreenTitleLabel()
    private let goBackButton = BackButtons()
    private let addTaskView = AddTaskView()
    private let tableView = UITableView()
    private var activities: [Activity] = []
    
    private let bottomSheetOverlay = UIView()
    private var activityBottomSheet: ActivityBottomSheetView?
    
    private var addTaskWidthConstraint: Constraint?
    private var addTaskHeightConstraint: Constraint?

    private var containerBottomConstraint: Constraint?
    
    private let containerView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupAddTaskView()
        setupTapGesture()
        setupKeyboardObservers()
        setupTableView()
        loadActivities()
        }
    
    func configureUI() {
        view.backgroundColor = UIColor(
            red: 244 / 255,
            green: 245 / 255,
            blue: 247 / 255,
            alpha: 1
        )
        view.addSubview(containerView)
        containerView.backgroundColor = UIColor(
            red: 244 / 255,
            green: 245 / 255,
            blue: 247 / 255,
            alpha: 1
        )
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            containerBottomConstraint = make.bottom.equalToSuperview().constraint
        }
        containerView.addSubview(navigationBar)
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
        goBackButton.addTarget(self, action: #selector(backButtonTapped( _:)), for: .touchUpInside)
        
        navigationBar.addSubview(screenNameLabel)
        screenNameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        screenNameLabel.text = ScreenNamesTitleStrings.taskListScreenTitle.rawValue
    }
    
    private func setupAddTaskView() {

        containerView.addSubview(addTaskView)

        addTaskView.snp.makeConstraints { make in

            addTaskWidthConstraint =
                make.width.equalTo(56).constraint

            addTaskHeightConstraint =
                make.height.equalTo(56).constraint

            make.trailing
                .equalToSuperview()
                .inset(20)

            make.bottom
                .equalToSuperview()
                .inset(20)
        }

        addTaskView.delegate = self
    }
    
    private func updateAddTaskViewSize(
        isExpanded: Bool,
        isDescriptionVisible: Bool = false,
        animated: Bool
    ) {
        let width: CGFloat = isExpanded ? 350 : 56

        let height: CGFloat

        if !isExpanded {
            height = 56
        } else if isDescriptionVisible {
            height = 300
        } else {
            height = 200
        }

        addTaskWidthConstraint?.update(offset: width)
        addTaskHeightConstraint?.update(offset: height)

        let animations = {
            self.view.layoutIfNeeded()
        }

        if animated {
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.85,
                initialSpringVelocity: 0.5,
                animations: animations
            )
        } else {
            animations()
        }
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleScreenTap(_:))
        )
        tapGesture.cancelsTouchesInView = false

        view.addGestureRecognizer(tapGesture)
    }

    @objc private func handleScreenTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)

        guard !addTaskView.frame.contains(location) else {
            return
        }

        addTaskView.collapse()
        view.endEditing(true)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func setupTableView() {
        containerView.addSubview(tableView)

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = true

        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(addTaskView.snp.top).offset(-16)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            ActivityCell.self,
            forCellReuseIdentifier: ActivityCell.reuseIdentifier
        )
        
    }
    
    private func loadActivities() {
        activities = ActivityStorage.shared.load()
        tableView.reloadData()
    }
    
    private func completeActivity(at index: Int) {
        guard activities.indices.contains(index) else {
            return
        }

        guard !activities[index].isCompleted else {
            return
        }

        activities[index].isCompleted = true
        activities[index].completedAt = Date().timeIntervalSince1970

        let activity = activities[index]

        ActivityStorage.shared.update(activity)

        tableView.reloadRows(
            at: [IndexPath(row: index, section: 0)],
            with: .automatic
        )
    }
    
    private func showActivityBottomSheet(for activity: Activity) {
        bottomSheetOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        bottomSheetOverlay.alpha = 0

        view.addSubview(bottomSheetOverlay)
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(bottomSheetOverlayTapped)
        )
        bottomSheetOverlay.addGestureRecognizer(tapGesture)

        bottomSheetOverlay.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let sheet = ActivityBottomSheetView(activity: activity)
        sheet.delegate = self
        activityBottomSheet = sheet

        view.addSubview(sheet)

        sheet.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.bounds.height * 0.5)
            make.top.equalTo(view.snp.bottom)
        }

        view.layoutIfNeeded()

        sheet.snp.updateConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(-view.bounds.height * 0.5)
        }

        UIView.animate(withDuration: 0.3) {
            self.bottomSheetOverlay.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideActivityBottomSheet() {
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomSheetOverlay.alpha = 0

            self.activityBottomSheet?.snp.updateConstraints { make in
                make.top.equalTo(self.view.snp.bottom)
            }

            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.activityBottomSheet?.removeFromSuperview()
            self.activityBottomSheet = nil
            self.bottomSheetOverlay.removeFromSuperview()
        })
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[
                UIResponder.keyboardFrameEndUserInfoKey
            ] as? CGRect,
            let duration = userInfo[
                UIResponder.keyboardAnimationDurationUserInfoKey
            ] as? TimeInterval
        else {
            return
        }

        let keyboardHeight = keyboardFrame.height

        containerBottomConstraint?.update(
            offset: -keyboardHeight
        )

        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let duration = userInfo[
                UIResponder.keyboardAnimationDurationUserInfoKey
            ] as? TimeInterval
        else {
            return
        }

        containerBottomConstraint?.update(offset: 0)

        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func backButtonTapped(_ Sender: UIButton ) {
        goBack()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func bottomSheetOverlayTapped() {
        hideActivityBottomSheet()
    }
}

extension ActivityFormViewController: AddTaskViewDelegate {

    func addTaskViewDidChangeState(
        _ view: AddTaskView,
        isExpanded: Bool
    ) {

        updateAddTaskViewSize(
            isExpanded: isExpanded,
            animated: true
        )
    }
    
    func addTaskViewDidChangeDescriptionState(
        _ view: AddTaskView,
        isVisible: Bool
    ) {
        updateAddTaskViewSize(
            isExpanded: true,
            isDescriptionVisible: isVisible,
            animated: true
        )
    }

    func addTaskView(
        _ view: AddTaskView,
        didTapSaveWith title: String,
        description: String
    ) {
        let activity = Activity(
            id: UUID(),
            title: title,
            description: description,
            createdAt: Date().timeIntervalSince1970
        )

        ActivityStorage.shared.save(activity)
        print("Активность сохранена:", activity.title)
        loadActivities()
    }
}

extension ActivityFormViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        activities.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: ActivityCell.reuseIdentifier,
            for: indexPath
        ) as! ActivityCell

        let activity = activities[indexPath.row]

        cell.configure(with: activity)

        cell.onCheckboxTapped = { [weak self] in
            self?.completeActivity(at: indexPath.row)
        }

        return cell
    }
}

extension ActivityFormViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)

        let activity = activities[indexPath.row]

        guard !activity.isCompleted else {
            return
        }

        showActivityBottomSheet(for: activity)
    }
}


extension ActivityFormViewController: ActivityBottomSheetViewDelegate {

    func activityBottomSheetDidTapClose() {
        hideActivityBottomSheet()
    }
}
