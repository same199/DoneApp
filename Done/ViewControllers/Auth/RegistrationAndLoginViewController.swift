//
//  RegistrationViewController.swift
//  Done
//
//  Created by LizOk&Same on 23.08.26.
//

import UIKit
import SnapKit

class RegistrationAndLoginViewController: UIViewController {
    
    private let bottomSheet = UIView()
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LoginAndRegistrationViewStrings.registrationButtoTittle.rawValue, for: .normal)
        return button
    }()
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LoginAndRegistrationViewStrings.loginButtonTittle.rawValue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
    }

    
    
    func configureUI() {
        view.backgroundColor = .systemPink
        view.addSubview(bottomSheet)
        bottomSheet.backgroundColor = .white
        bottomSheet.layer.cornerRadius = 16
        bottomSheet.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalToSuperview()
        }
        
        bottomSheet.addSubview(registrationButton)
        registrationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped( _:)), for: .touchUpInside)
        bottomSheet.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.centerX.equalTo(registrationButton)
            make.top.equalTo(registrationButton.snp.bottom).offset(16)
            make.width.equalTo(registrationButton)
            make.height.equalTo(registrationButton)
        }
    }
    
    private func goToMainScreen() {
        let controller = MainScreenViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func registrationButtonTapped(_ Sender: UIButton ) {
        goToMainScreen()
    }
}
