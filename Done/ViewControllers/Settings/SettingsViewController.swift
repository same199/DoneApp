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

        deleteAllDataButton.addTarget(
            self,
            action: #selector(deleteAllDataTapped),
            for: .touchUpInside
        )
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
}




