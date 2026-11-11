//
//  SettingsViewController.swift
//  Done
//
//  Created by LizOk&Same on 23.08.26.
//



import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    private let navigationBar = AppNavigationBar()
    private let goBackButton = BackButtons()
    private let screenNameLabel = ScreenTitleLabel()
    private let deleteAllDataButton = DeleteAllDataButton()
    private let logoutButton = LogoutFromSettingsButton()
    private let aboutAppButton = AboutAppButton()
    private let aboutAppView = AboutAppView()
    private let overlayView = UIView()
    private let userInfoButton = UserInfoButton()
    private let userInfoView = InfoAboutUserView()
    
    override func viewDidLoad() {
        configureUI()
        super.viewDidLoad()
        }
    
    func configureUI() {
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
        goBackButton.addTarget(self, action: #selector(backButtonTapped( _:)), for: .touchUpInside)
        
        navigationBar.addSubview(screenNameLabel)
        screenNameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        screenNameLabel.text = ScreenNamesTitleStrings.settingsScreenTitle.rawValue
        view.addSubview(deleteAllDataButton)

        deleteAllDataButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        view.addSubview(logoutButton)

        logoutButton.setTitle(LogoutAlertStrings.logoutAlertButtonTittle.rawValue, for: .normal)

        logoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(deleteAllDataButton.snp.top).offset(-12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }

        logoutButton.addTarget(
            self,
            action: #selector(logoutTapped),
            for: .touchUpInside
        )

        deleteAllDataButton.addTarget(
            self,
            action: #selector(deleteAllDataTapped),
            for: .touchUpInside
        )
        
        view.addSubview(aboutAppButton)
        aboutAppButton.setTitle(AboutAppString.aboutAppTitleState.rawValue, for: .normal)
        aboutAppButton.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        aboutAppButton.addTarget(self, action: #selector(aboutAppTapped), for: .touchUpInside)
        
        view.addSubview(userInfoButton)
        userInfoButton.setTitle(UserInfoString.userInfoTitleState.rawValue, for: .normal)
        userInfoButton.snp.makeConstraints { make in
            make.top.equalTo(aboutAppButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        userInfoButton.addTarget(self, action: #selector(userInfoTapped), for: .touchUpInside)
    }
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func deleteAllUserData() {
        ActivityStorage.shared.clear()
        AuthAndRegistrationManager.shared.deleteAllUserData()

        let authController = RegistrationAndLoginViewController()
        let navigationController = UINavigationController(
            rootViewController: authController
        )
        navigationController.setNavigationBarHidden(true, animated: false)

        guard let windowScene = view.window?.windowScene,
              let window = windowScene.windows.first else {
            return
        }

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func logoutUser() {
        AuthAndRegistrationManager.shared.logout()

        let authController = RegistrationAndLoginViewController()
        let navigationController = UINavigationController(
            rootViewController: authController
        )

        navigationController.setNavigationBarHidden(true, animated: false)

        guard let windowScene = view.window?.windowScene,
              let window = windowScene.windows.first else {
            return
        }

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    @objc private func backButtonTapped(_ Sender: UIButton ) {
        goBack()
    }
    
    
    @objc private func deleteAllDataTapped() {
        let alert = UIAlertController(
            title: DeleteAlertStrings.deleteAlertTitle.rawValue,
            message: DeleteAlertStrings.deleteAlertMessage.rawValue,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(
            title: DeleteAlertStrings.deleteAlertCancelButtonTitle.rawValue,
            style: .cancel
        ))

        alert.addAction(UIAlertAction(
            title: DeleteAlertStrings.deleteAlertDeleteButtonTitle.rawValue,
            style: .destructive
        ) { [weak self] _ in
            self?.deleteAllUserData()
        })

        present(alert, animated: true)
    }
    
    private func showAboutApp() {
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        overlayView.alpha = 0

        view.addSubview(overlayView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        overlayView.addSubview(aboutAppView)
        aboutAppView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }

        aboutAppView.alpha = 0

        UIView.animate(withDuration: 0.25) {
            self.overlayView.alpha = 1
            self.aboutAppView.alpha = 1
        }
    }
    
    private func hideAboutApp() {
        UIView.animate(withDuration: 0.25, animations: {
            self.overlayView.alpha = 0
            self.aboutAppView.alpha = 0
        }, completion: { _ in
            self.overlayView.removeFromSuperview()
            self.aboutAppView.removeFromSuperview()
        })
    }
    
    private func setupOverlayView() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(overlayTapped)
        )
        overlayView.addGestureRecognizer(tapGesture)
    }
    
    private func showAboutUserInfo() {
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        overlayView.alpha = 0

        view.addSubview(overlayView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        overlayView.addSubview(userInfoView)
        userInfoView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }

        userInfoView.alpha = 0

        UIView.animate(withDuration: 0.25) {
            self.overlayView.alpha = 1
            self.userInfoView.alpha = 1
        }
    }
    
    private func hideAboutUserInfo() {
        UIView.animate(withDuration: 0.25, animations: {
            self.overlayView.alpha = 0
            self.userInfoView.alpha = 0
        }, completion: { _ in
            self.overlayView.removeFromSuperview()
            self.userInfoView.removeFromSuperview()
        })
    }

    @objc private func overlayTapped() {
        hideAboutApp()
    }
    
    @objc private func logoutTapped() {
        let alert = UIAlertController(
            title: LogoutAlertStrings.logoutAlertTitle.rawValue,
            message: LogoutAlertStrings.logoutAlertMessage.rawValue,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(
            title: LogoutAlertStrings.logoutAlertCancelButtonTittle.rawValue,
            style: .cancel
        ))

        alert.addAction(UIAlertAction(
            title: LogoutAlertStrings.logoutAlertButtonTittle.rawValue,
            style: .destructive
        ) { [weak self] _ in
            self?.logoutUser()
        })

        present(alert, animated: true)
    }
    
    @objc private func aboutAppTapped() {
        setupOverlayView()
        showAboutApp()
    }
    
    @objc private func userInfoTapped() {
        setupOverlayView()
        showAboutUserInfo()
        print("User info tapped")
    }
}




