//
//  RegistrationViewController.swift
//  Done
//
//  Created by LizOk&Same on 23.08.26.
//

import UIKit
import SnapKit

class RegistrationAndLoginViewController: UIViewController {
    
    //    private let bottomSheet = UIView()
    private let authAndRegisterBottomSheet = AuthBottomSheetView()
    private var bottomSheetBottomConstraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupKeyboardObservers()
    }
    
    
    
    func configureUI() {
        view.backgroundColor = .systemPink
        view.addSubview(authAndRegisterBottomSheet)
        authAndRegisterBottomSheet.backgroundColor = .white
        authAndRegisterBottomSheet.layer.cornerRadius = 16
        authAndRegisterBottomSheet.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            bottomSheetBottomConstraint = make.bottom.equalToSuperview().constraint
            make.height.equalTo(150)
        }
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
    
    
//    private func goToMainScreen() {
//        let controller = MainScreenViewController()
//        navigationController?.pushViewController(controller, animated: true)
//    }
//    
//    @objc private func registrationButtonTapped(_ Sender: UIButton ) {
//        goToMainScreen()
//    }
    
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
    
}
