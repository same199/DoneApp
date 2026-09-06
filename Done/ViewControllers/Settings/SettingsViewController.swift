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
    
    override func viewDidLoad() {
        configureUI()
        super.viewDidLoad()
        }
    
    func configureUI() {
        view.backgroundColor = .yellow
        view.addSubview(navigationBar)
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
        screenNameLabel.text = ScreenNamesTitleStrings.settingsScreenTitle.rawValue
    }
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func backButtonTapped(_ Sender: UIButton ) {
        goBack()
    }
}




