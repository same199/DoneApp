//
//  RegistrationViewController.swift
//  Done
//
//  Created by LizOk&Same on 23.08.26.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    let bottomSheet = UIView()
    let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LoginAndRegistrationViewStrings.registrationButtoTittle.rawValue, for: .normal)
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
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped( _:)), for: .touchUpInside)
    }
    
    private func goToMainScreen() {
        let controller = MainScreenViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func registrationButtonTapped(_ Sender: UIButton ) {
        goToMainScreen()
    }
    
}
