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
        }
    
    func configureUI() {
        view.backgroundColor = .blue
        view.addSubview(containerView)
        containerView.backgroundColor = .blue
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
        goBackButton.setTitle(GoBackStrings.goBackButtonTittle.rawValue, for: .normal)
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
            addTaskWidthConstraint = make.width.equalTo(56).constraint
            addTaskHeightConstraint = make.height.equalTo(56).constraint

            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }

        addTaskView.onStateChanged = { [weak self] isExpanded in
            self?.updateAddTaskViewSize(
                isExpanded: isExpanded,
                animated: true
            )
        }
    }
    
    private func updateAddTaskViewSize(
        isExpanded: Bool,
        animated: Bool
    ) {
        let width: CGFloat = isExpanded ? 350 : 56
        let height: CGFloat = isExpanded ? 300 : 56

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
}
