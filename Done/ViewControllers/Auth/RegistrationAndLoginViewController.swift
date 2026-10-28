//
//  RegistrationViewController.swift
//  Done
//
//  Created by LizOk&Same on 23.08.26.
//

import UIKit
import SnapKit

class RegistrationAndLoginViewController: UIViewController, AuthBottomSheetViewDelegate {
    
    private let authAndRegisterBottomSheet = AuthBottomSheetView()
    private var bottomSheetBottomConstraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        authAndRegisterBottomSheet.delegate = self
        setupKeyboardObservers()
    }

    func configureUI() {
        view.backgroundColor = UIColor(
            red: 244.0 / 255.0,
            green: 245.0 / 255.0,
            blue: 247.0 / 255.0,
            alpha: 1
        )
        view.addSubview(authAndRegisterBottomSheet)
        authAndRegisterBottomSheet.backgroundColor = .white
        authAndRegisterBottomSheet.layer.cornerRadius = 20
        authAndRegisterBottomSheet.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        authAndRegisterBottomSheet.clipsToBounds = true
        authAndRegisterBottomSheet.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            bottomSheetBottomConstraint = make.bottom.equalToSuperview().constraint
            make.height.equalTo(150)
        }
    }
    
    private func goToMainScreen() {
        let controller = MainScreenViewController()
        navigationController?.pushViewController(controller, animated: true)
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

        bottomSheetBottomConstraint?.update(
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

        bottomSheetBottomConstraint?.update(offset: 0)

        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func authBottomSheetDidTapLogin() {
        authAndRegisterBottomSheet.showLogin()
    }

    func authBottomSheetDidTapRegistration() {
        authAndRegisterBottomSheet.showRegistration()
    }

    func authBottomSheetDidTapClose() {
        closeAuthBottomSheet()
    }
    
    private func closeAuthBottomSheet() {
        authAndRegisterBottomSheet.endEditing(true)
        authAndRegisterBottomSheet.showStart()
    }

    
    func authBottomSheetDidTapLoginSubmit(
        login: String,
        password: String
    ) {
        let savedEmail = AuthAndRegistrationManager.shared.getEmail()
        let savedPassword = AuthAndRegistrationManager.shared.getPassword()

        guard login == savedEmail,
              password == savedPassword else {
            authAndRegisterBottomSheet.setLoginFieldsError(true)
            print("Неверный логин или пароль")
            return
        }

        authAndRegisterBottomSheet.setLoginFieldsError(false)

        AuthAndRegistrationManager.shared.setAuthUser(true)
        goToMainScreen()
        closeAuthBottomSheet()
    }


    func authBottomSheetDidTapRegistrationSubmit(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        repeatPassword: String
    ) {
        guard password == repeatPassword else {
            print("Пароли не совпадают")
            return
        }

        AuthAndRegistrationManager.shared.userRegistration(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        )
        AuthAndRegistrationManager.shared.setAuthUser(true)
        goToMainScreen()
        closeAuthBottomSheet()
    }
}
